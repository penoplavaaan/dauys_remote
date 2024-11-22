import 'dart:convert';
import 'dart:async';
import 'package:stomp_dart_client/stomp_dart_client.dart';

class SocketService {
  late StompClient client;

  SocketService() {
    client = StompClient(
      config: StompConfig.sockJS(
          url: 'https://dligjs37pj7q2.cloudfront.net/im',
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
    client.deactivate();
  }

  void onConnect(StompFrame frame) {
    print('connected! ');

    client.subscribe(
      destination: '/user/1/msg',
      callback: (StompFrame frame) {
        print('Subscription received');
        print(frame.body);
        print(utf8.decode(frame.binaryBody ?? []));
        print(frame.command);
      },
    );

    Timer.periodic(const Duration(seconds: 2), (_) {
      client.send(
        destination: '/user/1/msg',
        body: jsonEncode({"a": 123}),
      );
    });
  }


}
