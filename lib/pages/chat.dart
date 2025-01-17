import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final List<ChatItem> chatItems = [
    ChatItem(name: "John Doe", message: "Hey there!", unreadCount: 3),
    ChatItem(name: "Jane Smith", message: "See you tomorrow!", unreadCount: 1),
    ChatItem(
        name: "Mike Johnson", message: "Thanks for the help", unreadCount: 2),
    ChatItem(name: "Sarah Wilson", message: "Got it, will do!", unreadCount: 0),
  ];

  ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('My Chats',
              style: TextStyle(
                color: Colors.teal,
                fontSize: 24,
                // fontWeight: FontWeight.bold,
              ))),
      body: ListView.builder(
        itemCount: chatItems.length,
        itemBuilder: (context, index) {
          return ChatListItem(chatItem: chatItems[index]);
        },
      ),
    );
  }
}

class ChatItem {
  final String name;
  final String message;
  final int unreadCount;

  ChatItem({
    required this.name,
    required this.message,
    required this.unreadCount,
  });
}

class ChatListItem extends StatelessWidget {
  final ChatItem chatItem;

  const ChatListItem({
    super.key,
    required this.chatItem,
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
        // Handle chat item tap
      },
    );
  }
}
