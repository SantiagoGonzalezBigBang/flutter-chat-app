import 'package:flutter/material.dart';

import 'package:chat/screens/screens.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'users'    : (BuildContext context) => const UsersScreen(),
  'chat'     : (BuildContext context) => const ChatScreen(),
  'login'    : (BuildContext context) => const LoginScreen(),
  'register' : (BuildContext context) => const RegisterScreen(),
  'loading'  : (BuildContext context) => const LoadingScreen(),
};