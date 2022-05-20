import 'dart:io';

import 'package:chat/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {   
  const ChatScreen({
    Key? key
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {

  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  final List<ChatMessage> _messages = [];

  bool _isWriting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue[100],
              maxRadius: 14.0,
              child: const Text(
                'Te',
                style: TextStyle(
                  fontSize: 12.0
                ),
              ),
            ),
            const SizedBox(height: 3.0,),
            const Text(
              'Melissa Flores',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 12.0
              ),
            )
          ],
        ),
        centerTitle: true,
        elevation: 1.0,
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              itemCount: _messages.length,
              physics: const BouncingScrollPhysics(),
              reverse: true,
              itemBuilder: (BuildContext context, int index) => _messages[index]
            ),
          ),
          const Divider(height: 1.0),
          Container(
            color: Colors.white,
            child: _buildInputChat(),
          )
        ],
      ),
    );
  }

  Widget _buildInputChat() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 8.0,
        ),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textEditingController,
                onSubmitted: _handleSubmit,
                onChanged: (value) {
                  setState(() {
                    if (value.trim().isNotEmpty) {
                      _isWriting = true;
                    } else {
                      _isWriting = false;
                    }
                  });
                },
                decoration: const InputDecoration.collapsed(
                  hintText: 'Enviar mensaje'
                ),
                focusNode: _focusNode,
              )
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 4.0
              ),
              child: Platform.isIOS ? CupertinoButton(
                onPressed: _isWriting ? () => _handleSubmit(_textEditingController.text) : null,
                child: const Text('Send')
              ) : Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 4.0
                ),
                child: IconTheme(
                  data: IconThemeData(
                    color: Colors.blue[400]
                  ),
                  child: IconButton(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onPressed: _isWriting ? () => _handleSubmit(_textEditingController.text) : null,
                    icon: const Icon(
                      Icons.send,
                    )
                  ),
                ),
              ),
            )
          ],
        ),
      )
    );
  }

  _handleSubmit(String value) {
    // print(value);

    if (value.isEmpty) return;

    _textEditingController.clear();
    _focusNode.requestFocus();
    _isWriting = false;  

    final newMessage = ChatMessage(
      uid: '123', 
      text: value,
      animationController: AnimationController(vsync: this, duration: const Duration(milliseconds: 200)),
    );
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();

    setState(() {});
  }

  @override
  void dispose() {
    
    for (var message in _messages) {
      message.animationController.dispose();
    }

    super.dispose();
  }

}