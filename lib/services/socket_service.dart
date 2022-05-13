import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';
//import 'package:socket_io_client/socket_io_client.dart';

enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  late IO.Socket _socket;

  ServerStatus get serverStatus => this._serverStatus;

  IO.Socket get socket => this._socket;

  Function get emit => this._socket.emit;

  SocketService() {
    this._initConfig();
  }

  void _initConfig() {
    // Dart client localhost:3000/   192.168.0.1:3000/
    //'http://10.0.2.2:3000'
    this._socket =
        IO.io('https://bandnames01.herokuapp.com/', <String, dynamic>{
      'transports': ['websocket'],
      //'extraHeaders': {'foo': 'bar'} // optional
    });
    //socket.connect();

    this._socket.on('connect', (_) {
      this._serverStatus = ServerStatus.Online;
      print("Hola Mundo");
      notifyListeners();
    });

    this._socket.on('disconnect', (_) {
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
    });

/*     this._socket.on('nuevo-mensaje', (payload) {
      //print('nuevo-ensaje: $payload');
      print('nuevo-ensaje:');
      print('nombre:' + payload['nombre']);
      print('mensaje:' + payload['mensaje']);
      print('mensaje:' + payload['mensaje']);
      print(payload.containsKey('mensaje2') ? payload['mensaje2'] : 'no hay');
    }); */
  }
}
