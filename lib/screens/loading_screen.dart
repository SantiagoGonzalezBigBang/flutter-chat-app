import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:chat/screens/screens.dart';
import 'package:chat/services/services.dart';

class LoadingScreen extends StatelessWidget {
   
  const LoadingScreen({
    Key? key
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return const Center(
            child: CircularProgressIndicator.adaptive()
          );
        },        
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {

    final socketService = Provider.of<SocketService>(context, listen: false);
    final authService   = Provider.of<AuthService>(context, listen: false);

    final isLoggedIn = await authService.isLoggedIn();

    if (isLoggedIn) {
      socketService.connect();
      _customNavigator(context: context, screen: const UsersScreen());
    } else {
      _customNavigator(context: context, screen: const LoginScreen());
    }

  }

  void _customNavigator({required BuildContext context, required Widget screen}) {
    Navigator.pushReplacement(context, PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionDuration: const Duration(milliseconds: 0)
    ));
  } 

}