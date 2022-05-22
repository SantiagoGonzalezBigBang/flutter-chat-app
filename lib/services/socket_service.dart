import 'package:chat/global/environment.dart';
import 'package:chat/services/services.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as socket_io;

enum ServerStatus {
  online,
  offline,
  connecting
}

class SocketService with ChangeNotifier {

  ServerStatus _serverStatus = ServerStatus.connecting;
  late socket_io.Socket _socket;
  
  ServerStatus get serverStatus => _serverStatus;
  socket_io.Socket get socket => _socket;
  // Function get emit => _socket.emit;

  void connect() async {
    
    final token = await AuthService.getToken();

    _socket = socket_io.io(Environment.socketUrl, 
      socket_io.OptionBuilder()
        .setTransports(['websocket'])
        .enableAutoConnect()
        .enableForceNew()
        .setExtraHeaders({
          'x-token' : token
        })
        .build()
    );

    _socket.onConnect((_) {
      _serverStatus = ServerStatus.online;
      notifyListeners();
    });

    _socket.onDisconnect((_) {
      _serverStatus = ServerStatus.offline;
      notifyListeners();
    });

    // _socket.on('nuevo-mensaje', (data) {
    //   print('nuevo-mensaje:');
    //   print('Nombre: ${data['nombre']}');
    //   print(data.containsKey('mensaje2') ? data['mensaje2'] : 'No hay');
    // });

  } 

  void disconnect() {
    _socket.disconnect();
  }

}