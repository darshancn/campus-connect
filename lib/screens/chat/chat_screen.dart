import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  final String name;
  final String imagePath;

  const ChatScreen({super.key, required this.name, required this.imagePath});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  Box? chatBox;

  @override
  void initState() {
    super.initState();
    _openChatBox();
  }

  Future<void> _openChatBox() async {
    chatBox = await Hive.openBox('chats');
    setState(() {});
  }

  String formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 1) {
      return "Just now";
    } else if (difference.inHours < 1) {
      return "${difference.inMinutes} min ago";
    } else if (difference.inDays < 1) {
      return DateFormat('HH:mm').format(time);
    } else if (difference.inDays < 2) {
      return "Yesterday";
    } else {
      return DateFormat('dd MMM').format(time);
    }
  }

  void _sendMessage() {
    if (_messageController.text.isNotEmpty && chatBox != null) {
      final message = {
        'text': _messageController.text,
        'time': DateTime.now().toIso8601String(),
        'isMe': true,
      };
      chatBox!.add(message);
      _messageController.clear();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Row(
          children: [
            CircleAvatar(backgroundImage: AssetImage(widget.imagePath)),
            const SizedBox(width: 10),
            Text(widget.name, style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child:
                chatBox == null
                    ? const Center(child: CircularProgressIndicator())
                    : ValueListenableBuilder(
                      valueListenable: chatBox!.listenable(),
                      builder: (context, box, _) {
                        return ListView.builder(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          itemCount: chatBox!.length,
                          itemBuilder: (context, index) {
                            final message = chatBox!.getAt(index);
                            bool isMe = message['isMe'] ?? false;
                            DateTime messageTime = DateTime.parse(
                              message['time'],
                            );

                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Align(
                                alignment:
                                    isMe
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                child: Column(
                                  crossAxisAlignment:
                                      isMe
                                          ? CrossAxisAlignment.end
                                          : CrossAxisAlignment.start,
                                  children: [
                                    if (!isMe)
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundImage: AssetImage(
                                              widget.imagePath,
                                            ),
                                            radius:
                                                11.5, // Width & height = 23px
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            widget.name,
                                            style: const TextStyle(
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                              letterSpacing: 0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    Container(
                                      constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width *
                                            0.7,
                                      ),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black26,
                                            blurRadius: 4,
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            message['text'],
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            formatTime(messageTime),
                                            style: const TextStyle(
                                              fontSize: 10,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 0,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (isMe)
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          right: 5,
                                          top: 2,
                                        ),
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            "Me",
                                            style: const TextStyle(
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                              letterSpacing: 0,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(color: Colors.black26, blurRadius: 4),
                      ],
                    ),
                    child: TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 18,
                        ),
                        hintText: 'Type here ...',
                        hintStyle: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          letterSpacing: 0,
                          color: Colors.black,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF1D97D4),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white, size: 19),
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
}
