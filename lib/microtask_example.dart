import 'dart:async';

class MicrotaskExample {
  void createMicrotask(int index) {
    scheduleMicrotask(() async {
      await Future.delayed(
          index == 1 ? Duration(seconds: 20) : Duration(seconds: 3));
      return print(index);
    });
  }
}
