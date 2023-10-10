import 'package:chat_app/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final usuarios = [
    Usuario(true, 'topo@topo.com', 'Topo', '1'),
    Usuario(false, 'fio@fio.com', 'Fio', '2'),
  ];
  final RefreshController _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        title: Text('Name'),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: () {},
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
        header: WaterDropMaterialHeader(
          offset: 4,
          backgroundColor: Colors.grey.shade300,
          distance: 30,
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

  ListTile _user(Usuario usuario) {
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
    await Future.delayed(Duration(milliseconds: 700));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}
