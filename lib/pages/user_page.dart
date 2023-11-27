import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:chat_app/config/theme/apptext_theme.dart';
import 'package:chat_app/models/models.dart';
import 'package:chat_app/services/services.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final RefreshController _refreshController = RefreshController();
  final userService = UserService();
  List<User> users = [];

  @override
  void initState() {
    _loadUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Chatting!',
          style: AppTextTheme.logoTitle?.copyWith(fontSize: 22),
        ),
        elevation: 0,
        actions: [
          _menuOptions(socketService.serverStatus),
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        header: MaterialClassicHeader(
          offset: 2,
          backgroundColor: Colors.grey.shade300,
          distance: 25,
          color: Colors.grey.shade900,
        ),
        onRefresh: () => _loadUsers(),
        child: _userList(),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        highlightElevation: 0,
        onPressed: () {},
        child: const Icon(Icons.chat),
      ),
    );
  }

  PopupMenuButton<dynamic> _menuOptions(dynamic status) {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            enabled: false,
            title: (status == ServerStatus.Online)
                ? Text('Socket conectado', style: AppTextTheme.greyBody)
                : Text('Socket desconectado', style: AppTextTheme.greyBody),
            leading: (status == ServerStatus.Online)
                ? Icon(Icons.check_circle, color: Colors.green[400])
                : Icon(Icons.cancel, color: Colors.red[400]),
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text('Salir', style: AppTextTheme.greyBody),
            leading: Icon(Icons.exit_to_app, color: Colors.grey.shade600),
            onTap: () {
              Provider.of<SocketService>(context, listen: false).disconnect();
              AuthService.deleteToken();
              Navigator.pushNamedAndRemoveUntil(
                  context, 'login', (route) => false);
            },
          ),
        ),
      ],
    );
  }

  ListView _userList() {
    return ListView.separated(
      itemCount: users.length,
      separatorBuilder: (_, index) => Divider(
        color: Colors.grey[100],
      ),
      itemBuilder: (_, i) => _users(users[i]),
    );
  }

  ListTile _users(User user) {
    return ListTile(
      title: Text(
        user.name,
        style: AppTextTheme.greyBody?.copyWith(fontSize: 15),
      ),
      leading: Stack(
        children: [
          CircleAvatar(
            radius: 25,
            child: Text(user.name.substring(0, 2)),
          ),
          Positioned(
            right: 2,
            bottom: 2,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: user.online ? Colors.green[400] : Colors.red[400],
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
        ],
      ),
      onTap: () {
        final chatService = Provider.of<ChatService>(context, listen: false);
        chatService.userTo = user;
        Navigator.pushNamed(context, 'chat');
      },
    );
  }

  void _loadUsers() async {
    users = await userService.getUsers();
    setState(() {});
    _refreshController.refreshCompleted();
  }
}
