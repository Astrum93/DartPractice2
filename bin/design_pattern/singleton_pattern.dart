import 'dart:isolate';

class SingletonObject {
  int count = 0;

  SingletonObject._();

  static final SingletonObject instance = SingletonObject._();

  factory SingletonObject() {
    return instance;
  }
}
