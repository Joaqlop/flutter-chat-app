import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:chat_app/models/user.dart';
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
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        title: Text(authService.user.name),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.exit_to_app),
          onPressed: () {
            socketService.disconnect();
            AuthService.deleteToken();
            Navigator.pushReplacementNamed(context, 'login');
          },
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: (socketService.serverStatus == ServerStatus.Online)
                ? Icon(Icons.check_circle, color: Colors.green[400])
                : Icon(Icons.cancel, color: Colors.red[400]),
          )
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
      title: Text(user.name),
      subtitle: Text(user.email),
      leading: CircleAvatar(
        child: Text(user.name.substring(0, 2)),
      ),
      trailing: Container(
        width: 11,
        height: 11,
        decoration: BoxDecoration(
          color: user.online ? Colors.green[400] : Colors.red[400],
          borderRadius: BorderRadius.circular(100),
        ),
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
