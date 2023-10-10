import 'package:chat_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

import 'package:chat_app/config/theme/apptext_theme.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _chatController = TextEditingController();
  final _focusNode = FocusNode();
  bool _writing = false;

  List<ChatMessages> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        elevation: 1,
        title: Row(
          children: [
            const CircleAvatar(
              child: Text('Te'),
            ),
            const SizedBox(width: 10),
            Column(
              children: [
                Text('Test User', style: AppTextTheme.greyBody),
                Text('info',
                    style: AppTextTheme.greyBody?.copyWith(fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              itemCount: _messages.length,
              reverse: true,
              itemBuilder: (_, i) => _messages[i],
            ),
          ),
          const SizedBox(height: 15),
          _inputChat(),
        ],
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
      child: Container(
        height: 50,
        margin: const EdgeInsets.only(left: 10, bottom: 10),
        child: Row(
          children: [
            Flexible(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  controller: _chatController,
                  onSubmitted: _handleSubmit,
                  onChanged: (String text) {
                    setState(() {
                      if (text.trim().isNotEmpty) {
                        _writing = true;
                      } else {
                        _writing = false;
                      }
                    });
                  },
                  focusNode: _focusNode,
                  decoration: const InputDecoration.collapsed(
                    hintText: 'Mensaje',
                  ),
                ),
              ),
            ),
            IconTheme(
              data: const IconThemeData(
                color: Colors.blue,
              ),
              child: IconButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                icon: const Icon(
                  Icons.send,
                  size: 20,
                ),
                onPressed:
                    _writing ? () => _handleSubmit(_chatController.text) : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _handleSubmit(String text) {
    if (text.isEmpty) return;
    _chatController.clear();
    _focusNode.requestFocus();
    final newMessage = ChatMessages(
      text: text,
      uid: '123',
      animationController: AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
      ),
    );
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();
    setState(() {
      _writing = false;
    });
  }

  @override
  void dispose() {
    // Socket OFF
    for (ChatMessages message in _messages) {
      message.animationController.dispose();
    }
    super.dispose();
  }
}
