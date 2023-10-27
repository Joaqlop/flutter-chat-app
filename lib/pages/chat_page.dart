import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:chat_app/config/theme/apptext_theme.dart';
import 'package:chat_app/models/models.dart';
import 'package:chat_app/services/services.dart';
import 'package:chat_app/widgets/widgets.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _chatController = TextEditingController();
  final _focusNode = FocusNode();
  bool _writing = false;

  late AuthService authService;
  late ChatService chatService;
  late SocketService socketService;

  final List<ChatMessages> _messages = [];

  @override
  void initState() {
    super.initState();

    authService = Provider.of<AuthService>(context, listen: false);
    chatService = Provider.of<ChatService>(context, listen: false);
    socketService = Provider.of<SocketService>(context, listen: false);

    socketService.socket.on('new-message', (data) => _listenMessage);
    _loadChat(chatService.userTo.uid);
  }

  @override
  Widget build(BuildContext context) {
    final user = chatService.userTo;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        elevation: 1,
        title: Row(
          children: [
            CircleAvatar(
              child: Text(user.name.substring(0, 2)),
            ),
            const SizedBox(width: 10),
            Text(user.name, style: AppTextTheme.greyBody),
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
      uid: authService.user.uid,
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

    socketService.emit('new-message', {
      'from': authService.user.uid,
      'to': chatService.userTo.uid,
      'message': text,
    });
  }

  void _listenMessage(dynamic data) {
    ChatMessages message = ChatMessages(
      text: data['message'],
      uid: data['from'],
      animationController: AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
      ),
    );

    setState(() {
      _messages.insert(0, message);
    });

    message.animationController.forward();
  }

  void _loadChat(String uid) async {
    List<Message> chat = await chatService.getChat(uid);

    final historyChat = chat.map(
      (m) => ChatMessages(
        text: m.message,
        uid: m.from,
        animationController: AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 400),
        )..forward(),
      ),
    );

    setState(() {
      _messages.insertAll(0, historyChat);
    });
  }

  @override
  void dispose() {
    for (ChatMessages message in _messages) {
      message.animationController.dispose();
    }

    //Socket Off
    socketService.socket.off('new-message');
    super.dispose();
  }
}
