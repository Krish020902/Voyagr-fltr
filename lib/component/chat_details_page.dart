import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

// Message model
class Message {
  final String text;
  final bool isSentByMe;
  final DateTime time;

  Message({
    required this.text,
    required this.isSentByMe,
    required this.time,
  });
}

class ChatDetailPage extends StatefulWidget {
  final chatItem;
  final int? loggedInUserId;

  const ChatDetailPage({
    super.key,
    required this.chatItem,
    this.loggedInUserId,
  });

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final TextEditingController _messageController = TextEditingController();
  final List<Message> _messages = [];
  final ScrollController _scrollController = ScrollController();
  late IO.Socket socket;

  @override
  void initState() {
    super.initState();
    connectToSocket();

    // Populate with some sample messages
    _messages.addAll([
      Message(
        text: "Hi there! How are you?",
        isSentByMe: false,
        time: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
      ),
      Message(
        text: "I'm good, thanks for asking!",
        isSentByMe: true,
        time: DateTime.now().subtract(const Duration(days: 1, hours: 1, minutes: 45)),
      ),
      Message(
        text: "What about you?",
        isSentByMe: true,
        time: DateTime.now().subtract(const Duration(days: 1, hours: 1, minutes: 44)),
      ),
      Message(
        text: "I'm doing well too! Just wanted to check in.",
        isSentByMe: false,
        time: DateTime.now().subtract(const Duration(days: 1, minutes: 30)),
      ),
      Message(
        text: widget.chatItem.message,
        isSentByMe: false,
        time: DateTime.now().subtract(const Duration(minutes: 5)),
      ),
    ]);

    // Scroll to bottom initially
    _scrollToBottom();
  }

  @override
  void dispose() {
    socket.disconnect();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void connectToSocket() {
    try {
      socket = IO.io('https://voyagr-backend.onrender.com', <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
        'query': {
          'userId': widget.loggedInUserId.toString(),
          'recipientId': widget.chatItem.id.toString(),
        },
      });
      socket.onConnect((data) {
        print('Connected to chat socket');
        socket.on("message", (msg) {
          print('Received message from server: $msg');
        });
      });
      socket.on('connect', (_) {
        print('Socket connection established');
        socket.emit('join', {
          'userId': widget.loggedInUserId,
          'recipientId': widget.chatItem.id,
        });
      });

      socket.on('message', (data) {
        print('Message received: $data');
        if (mounted) {
          setState(() {
            _messages.add(Message(
              text: data['text'],
              isSentByMe: data['senderId'] == widget.loggedInUserId,
              time: DateTime.now(),
            ));
          });
          _scrollToBottom();
        }
      });

      socket.on('connect_error', (error) {
        print('Connection error: $error');
      });

      socket.connect();
    } catch (e) {
      print('Socket initialization error: $e');
    }
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    final messageText = _messageController.text.trim();

    setState(() {
      _messages.add(Message(
        text: messageText,
        isSentByMe: true,
        time: DateTime.now(),
      ));
      _messageController.clear();
    });

    // Send message via socket
    socket.emit('message', {
      'senderId': widget.loggedInUserId,
      'recipientId': widget.chatItem.id,
      'text': messageText,
      'timestamp': DateTime.now().toIso8601String(),
    });

    _scrollToBottom();
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final messageDate = DateTime(time.year, time.month, time.day);

    if (messageDate == today) {
      return 'Today, ${DateFormat.jm().format(time)}';
    } else if (messageDate == yesterday) {
      return 'Yesterday, ${DateFormat.jm().format(time)}';
    } else {
      return DateFormat('MMM d, h:mm a').format(time);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.tealAccent,
              child: Text(
                widget.chatItem.name[0],
                style: const TextStyle(color: Colors.teal),
              ),
            ),
            const SizedBox(width: 5),
            Text(
              widget.chatItem.name,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Handle more options
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Chat messages
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildMessageBubble(message);
              },
            ),
          ),
          // Message input
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, -1),
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.attach_file, color: Colors.teal),
                  onPressed: () {
                    // Handle attachment
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.teal,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Message message) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: message.isSentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (message.isSentByMe) const Spacer(),
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: message.isSentByMe ? Colors.teal : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(16).copyWith(
                bottomRight: message.isSentByMe ? const Radius.circular(0) : null,
                bottomLeft: !message.isSentByMe ? const Radius.circular(0) : null,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message.text,
                  style: TextStyle(
                    color: message.isSentByMe ? Colors.white : Colors.black87,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _formatTime(message.time),
                  style: TextStyle(
                    color: message.isSentByMe ? Colors.white.withOpacity(0.7) : Colors.black54,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          if (!message.isSentByMe) const Spacer(),
        ],
      ),
    );
  }
}
