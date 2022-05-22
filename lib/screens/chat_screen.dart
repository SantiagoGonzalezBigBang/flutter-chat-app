import 'dart:io';

import 'package:chat/models/models.dart';
import 'package:chat/services/services.dart';
import 'package:chat/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  late ChatService chatService;
  late SocketService socketService;
  late AuthService authService;

  final List<ChatMessage> _messages = [];

  bool _isWriting = false;

  @override
  void initState() {
    super.initState();
    chatService   = Provider.of<ChatService>(context, listen: false);
    socketService = Provider.of<SocketService>(context, listen: false);
    authService   = Provider.of<AuthService>(context, listen: false);

    socketService.socket.on('mensaje-personal', _listenMessage);

    _cargarHistorial(chatService.userModel!.uid);
  }

  void _cargarHistorial(String userId) async {
    List<Mensaje> chat = await chatService.getChat(userId); 
    
    final history = chat.map((e) => ChatMessage(
      uid: e.de, 
      text: e.mensaje, 
      animationController: AnimationController(vsync: this, duration: const Duration(milliseconds: 0))..forward()
    ));

    setState(() {
      _messages.insertAll(0, history);
    });
  }

  void _listenMessage(dynamic data) {
    ChatMessage newMessage = ChatMessage(
      uid: data['de'], 
      text: data['mensaje'], 
      animationController: AnimationController(vsync: this, duration: const Duration(milliseconds: 300))
    );
    setState(() {
      _messages.insert(0, newMessage);
    });

    newMessage.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {

    final userModel = chatService.userModel!;
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue[100],
              maxRadius: 14.0,
              child: Text(
                userModel.name.substring(0,2),
                style: const TextStyle(
                  fontSize: 12.0
                ),
              ),
            ),
            const SizedBox(height: 3.0,),
            Text(
              userModel.name,
              style: const TextStyle(
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

    if (value.isEmpty) return;

    _textEditingController.clear();
    _focusNode.requestFocus();

    final newMessage = ChatMessage(
      uid: authService.userModel!.uid, 
      text: value,
      animationController: AnimationController(vsync: this, duration: const Duration(milliseconds: 300)),
    );
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();

    _isWriting = false;  
    setState(() {});

    socketService.socket.emit('mensaje-personal', {
      'de'  : authService.userModel!.uid,
      'para': chatService.userModel!.uid,
      'mensaje' : value
    });

  }

  @override
  void dispose() {
    
    for (var message in _messages) {
      message.animationController.dispose();
    }

    socketService.socket.off('mensaje-personal');

    super.dispose();
  }

}