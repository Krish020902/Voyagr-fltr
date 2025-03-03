import 'package:flutter/material.dart';
import 'package:Voyagr/component/chat_details_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatItem> chatItems = [
    ChatItem(id: '1', name: "Krish Mehta", message: "Hey there!", unreadCount: 3),
    ChatItem(id: '2', name: "Jane Smith", message: "See you tomorrow!", unreadCount: 1),
    ChatItem(id: '3', name: "Mike Johnson", message: "Thanks for the help", unreadCount: 2),
    ChatItem(id: '4', name: "Sarah Wilson", message: "Got it, will do!", unreadCount: 0),
  ];

  List<ChatItem> filteredChatItems = [];
  int? loggedInUserId;
  ChatItem? loggedInUser;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getLoggedInUser();
  }

  Future<void> _getLoggedInUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId') ?? '1';

      setState(() {
        loggedInUserId = int.tryParse(userId);
        loggedInUser = chatItems.firstWhere(
          (item) => item.id == userId,
          orElse: () => ChatItem(id: userId, name: "Me", message: "", unreadCount: 0),
        );

        filteredChatItems = chatItems.where((item) => item.id != userId).toList();
        isLoading = false;
      });
    } catch (e) {
      print('Error getting logged in user: $e');
      setState(() {
        isLoading = false;
        filteredChatItems = chatItems;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'My Chats',
          style: TextStyle(
            color: Colors.teal,
            fontSize: 24,
          ),
        ),
        actions: [
          if (loggedInUser != null)
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: CircleAvatar(
                backgroundColor: Colors.teal,
                child: Text(
                  loggedInUser!.name[0],
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: Colors.teal))
          : filteredChatItems.isEmpty
              ? Center(child: Text('No chats available'))
              : ListView.builder(
                  itemCount: filteredChatItems.length,
                  itemBuilder: (context, index) {
                    return ChatListItem(
                      chatItem: filteredChatItems[index],
                      loggedInUserId: loggedInUserId,
                    );
                  },
                ),
    );
  }
}

class ChatItem {
  final String id;
  final String name;
  final String message;
  final int unreadCount;

  ChatItem({
    required this.id,
    required this.name,
    required this.message,
    required this.unreadCount,
  });
}

class ChatListItem extends StatelessWidget {
  final ChatItem chatItem;
  final int? loggedInUserId;

  const ChatListItem({
    super.key,
    required this.chatItem,
    this.loggedInUserId,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.teal,
        child: Text(
          chatItem.name[0],
          style: TextStyle(color: Colors.white),
        ),
      ),
      title: Text(
        chatItem.name,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(chatItem.message),
      trailing: chatItem.unreadCount > 0
          ? Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.teal,
                shape: BoxShape.circle,
              ),
              child: Text(
                chatItem.unreadCount.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            )
          : null,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatDetailPage(
              chatItem: chatItem,
              loggedInUserId: loggedInUserId,
            ),
          ),
        );
      },
    );
  }
}
