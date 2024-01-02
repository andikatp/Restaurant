import 'dart:isolate';
import 'dart:ui';

final ReceivePort port = ReceivePort();
 
class BackgroundService {
 
  factory BackgroundService() => _instance ?? BackgroundService._internal();
 
  BackgroundService._internal() {
    _instance = this;
  }
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;
 
  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }
 
  static Future<void> callback() async {
    print('Alarm fired!');
    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
 
  Future<void> someTask() async {
    print('Updated data from the background isolate');
  }
}
