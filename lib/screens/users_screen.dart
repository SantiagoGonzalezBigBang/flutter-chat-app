import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:chat/models/models.dart';
import 'package:chat/services/services.dart';

class UsersScreen extends StatefulWidget {   
  const UsersScreen({
    Key? key
  }) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {

  final getUsersService = GetUsersService();
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  List<UserModel> users = [];

  @override
  void initState() {
    _loadUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final socketService = Provider.of<SocketService>(context);
    final authService   = Provider.of<AuthService>(context);
    final UserModel userModel = authService.userModel!;

    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          userModel.name,
          style: const TextStyle(
            color: Colors.black87
          ),
        ),
        elevation: 1.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            socketService.disconnect();
            Navigator.pushReplacementNamed(context, 'login');
            authService.logout();
          }, 
          icon: const Icon(
            Icons.exit_to_app,
            color: Colors.black87
          )
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10.0),
            child: socketService.serverStatus == ServerStatus.online ? Icon(
              Icons.check_circle,
              color: Colors.blue[400],
            ) : const Icon(
              Icons.offline_bolt,
              color: Colors.red,
            ),
          )
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _loadUsers,
        header: WaterDropHeader(
          complete: Icon(Icons.check, color: Colors.blue[400]),
          waterDropColor: Colors.blue[400] ?? Colors.blue,
        ),
        child: _buildUsersListView(),
      )
    );
  }

  ListView _buildUsersListView() {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: users.length,
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemBuilder: (BuildContext context, int index) {
        return _buildUserListTile(users[index]);
      },
    );
  }

  ListTile _buildUserListTile(UserModel userModel) {
    return ListTile(
      title: Text(
        userModel.name
      ),
      subtitle: Text(
        userModel.email
      ),
      leading: CircleAvatar(
        backgroundColor: Colors.blue[100],
        child: Text(
          userModel.name.substring(0,2)
        ),
      ),
      trailing: Container(
        width: 10.0,
        height: 10.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: userModel.isOnline ? Colors.green[300] : Colors.red
        ),
      ),
      onTap: () {
        final chatService = Provider.of<ChatService>(context, listen: false);
        chatService.userModel = userModel;
        Navigator.pushNamed(context, 'chat');
      },
    );
  }

  _loadUsers() async {
    users = await getUsersService.getUsers();
    setState(() {});

    _refreshController.refreshCompleted();
  }

}