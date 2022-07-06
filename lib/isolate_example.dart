import 'dart:isolate';

class IsolateExample {
  late SendPort newIsolateSendPort;

  Isolate? newIsolate;

  void callerCreateIsolate({int index = 0}) async {
    ReceivePort receivePort = ReceivePort();

    newIsolate = await Isolate.spawn(
      callbackFunction,
      [receivePort.sendPort, index],
    );

    newIsolateSendPort = await receivePort.first;
    newIsolate!.kill(priority: Isolate.immediate);
    newIsolate = null;
  }

  static void callbackFunction(List arguments) async {
    ReceivePort newIsolateReceivePort = ReceivePort();

    await Future.delayed(
        arguments.last == 1 ? Duration(seconds: 20) : Duration(seconds: 3));
    print('>>>>>>>>> ${arguments.last}');

    SendPort sendPort = arguments.first;
    sendPort.send(newIsolateReceivePort.sendPort);
  }
}
