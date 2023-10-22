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
  final usuarios = [
    User(name: 'Topo', email: 'topo@topo.com', online: true, uid: '2'),
    User(name: 'Fio', email: 'fio@fio.com', online: false, uid: '1212'),
  ];
  final RefreshController _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        title: Text(authService.user!.name),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.exit_to_app),
          onPressed: () {
            //TODO Disconnect Socket Server
            Navigator.pushReplacementNamed(context, 'login');
            AuthService.deleteToken();
          },
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: //Icon(Icons.check_circle, color: Colors.greenAccent),
                Icon(Icons.cancel, color: Colors.red[400]),
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
        onRefresh: () => _refresh(),
        child: _userList(),
      ),
    );
  }

  ListView _userList() {
    return ListView.separated(
      itemCount: usuarios.length,
      separatorBuilder: (_, index) => Divider(
        color: Colors.grey[100],
      ),
      itemBuilder: (_, i) => _user(usuarios[i]),
    );
  }

  ListTile _user(User usuario) {
    return ListTile(
      title: Text(usuario.name),
      subtitle: Text(usuario.email),
      leading: CircleAvatar(
        child: Text(usuario.name.substring(0, 2)),
      ),
      trailing: Container(
        width: 11,
        height: 11,
        decoration: BoxDecoration(
          color: usuario.online ? Colors.green[400] : Colors.red[400],
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }

  void _refresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 700));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}
