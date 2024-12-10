import 'dart:convert';
import 'dart:async';
import 'package:dauys_remote/api/api.dart';
import 'package:dauys_remote/models/user_model.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

import '../models/song_new.dart';

class SocketService {
  static const String incomingMessageTypeHandshake = 'INCOMING_HANDSHAKE';

  static const String messageTypeHandshake = 'HANDSHAKE';
  static const String messageTypeGoodbye = 'GOODBYE';
  static const String messageTypePlay = 'PLAY';

  static const String commandTypePlay = 'play';
  static const String commandTypeBeforePlay = 'beforePlay';
  static const String commandTypePause = 'pause';
  static const String commandTypeStop = 'stop';
  static const String commandTypeHandshake= 'handshake';
  static const String commandTypeGoodbye = 'handshake';
  static const String commandTypeResume = 'resume';

  late StompClient client;
  User user;
  SongNew song;
  bool _isConnected = false;
  int deviceId = 0;
  int micCount = 1;

  SocketService(this.user,this.song, this.micCount);

  Future<void> configure() async{
    client = StompClient(
      config: StompConfig.sockJS(
          url: '${Api.baseUrl}/im',
          onConnect: onConnect,
          beforeConnect: () async {
            print('waiting to connect...');
            await Future.delayed(const Duration(milliseconds: 200));
            print('connecting...');
          },

          onStompError: (dynamic error) {
            print('WebSocket error: $error');
          },
          onWebSocketError: (dynamic error) {
            print('WebSocket error: $error');
          }
      ),
    );

    client.activate();
  }

  void deactivate(){
    onStop();
    sendGoodbye();
    client.deactivate();
  }

  bool isConnected() {
    return client.isActive;
  }

  void onConnect(StompFrame frame) {
    print('connected! ');

    client.subscribe(
      destination: '/user/${user.id}/msg',
      callback: (StompFrame frame) {
        parseIncomingMessage(utf8.decode(frame.binaryBody ?? []) );
      },
    );

    sendHandshake();
    mockSuccessHandshake();
    // beforePlay();
  }

  parseIncomingMessage(String message){
    print('Subscription received');
    var mes = jsonDecode(message);
    print(mes);

    if(
      (mes['message']['type'] == incomingMessageTypeHandshake)
      && (mes['message']['command'] == commandTypeHandshake)
    ) {
      print('handshake success');
      _isConnected = true;
      deviceId = mes['message']['deviceId'] ?? 0;
    }
  }

  void send(Object body){
    client.send(
      destination: '/user/${user.id}/msg',
      body: jsonEncode(body),
    );
  }

  void sendHandshake(){
    send({
      'message': {
        'type': messageTypeHandshake,
        'command': commandTypeHandshake
      },
      'data': {
        'micCount': micCount,
        'deviceId': deviceId
      }
    });
  }


  void sendGoodbye(){
    send({
      'message': {
        'type': messageTypeGoodbye,
        'command': commandTypeGoodbye
      },
      'data': null,
      'deviceId': deviceId
    });
  }

  void beforePlay(){
    send({
      'message': {
        'type': messageTypePlay,
        'command': commandTypeBeforePlay
      },
      'data': {
        'songId' : song.id,
        'deviceId': deviceId
      }
    });
  }

  void onPlay(){
    send({
      'message': {
        'type': messageTypePlay,
        'command': commandTypePlay
      },
      'data': {
        'songId' : song.id,
        'deviceId': deviceId
      }
    });
  }

  void onResume(){
    send({
      'message': {
        'type': messageTypePlay,
        'command': commandTypeResume
      },
      'data': {
        'songId' : song.id,
        'deviceId': deviceId
      }
    });
  }

  void onPause(){
    send({
      'message': {
        'type': messageTypePlay,
        'command': commandTypePause
      },
      'data': {
        'songId' : song.id,
        'deviceId': deviceId
      }
    });
  }

  void onStop(){
    send({
      'message': {
        'type': messageTypePlay,
        'command': commandTypeStop
      },
      'data': {
        'songId' : song.id,
        'deviceId': deviceId
      }
    });
  }


  //mock part
  void mockSuccessHandshake (){
    send({
      'message': {
        'type': incomingMessageTypeHandshake,
        'command': commandTypeHandshake
      },
      'data': {
        'deviceId' : deviceId
      }
    });
  }
}
