import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:chat/routes/routes.dart';
import 'package:chat/services/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService(),),
        ChangeNotifierProvider(create: (context) => SocketService(),),
        ChangeNotifierProvider(create: (context) => ChatService(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat',
        initialRoute: 'loading',
        routes: appRoutes,
      ),
    );
  }
}