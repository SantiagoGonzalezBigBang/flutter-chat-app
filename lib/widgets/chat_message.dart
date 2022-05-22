import 'package:chat/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatMessage extends StatelessWidget {

  const ChatMessage({
    Key? key, 
    required this.uid,
    required this.text, 
    required this.animationController
  }) : super(key: key);

  final String text;
  final String uid;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context, listen: false);

    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(
          parent: animationController,
          curve: Curves.easeOut
        ),
        child: uid == authService.userModel!.uid ? _buildMyMessage() : _buildNotMyMessage(),
      ),
    );
  }

  Widget _buildMyMessage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 5.0,
          right: 5.0,
          left: 50.0,
        ),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: const Color(0xff4D9EF6),
          borderRadius: BorderRadius.circular(20.0)
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white
          ),
        ),
      ),
    );
  }

  Widget _buildNotMyMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 5.0,
          left: 5.0,
          right: 50.0,
        ),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: const Color(0xffE4E5E8),
          borderRadius: BorderRadius.circular(20.0)
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.black87
          ),
        ),
      ),
    );
  }
}