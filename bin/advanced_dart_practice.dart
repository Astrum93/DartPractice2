import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'extention/collection_extention.dart';

////////////////////////////////////////////////////////////////////////////

/// Class

abstract class Animal {
  walk();
}

class Dog extends Animal {
  void walk() {
    print('Dog is walking');
  }
}

class Cat extends Animal {
  void walk() {
    print('Cat is walking');
  }
}

class Duck extends Animal {
  void walk() {
    print('Duck is walk');
  }
}

////////////////////////////////////////////////////////////////////////////

/// Generic Class

/// Generic 사용 전
class ResultString {
  final String data;

  ResultString(this.data);
}

class ResultDouble {
  final String data;

  ResultDouble(this.data);
}

/////////////////////////////////

/// Generic 사용 후
class Result<T> {
  final T data;

  Result(this.data);
}

/////////////////////////////////////////////////////

/// Generic 사용 전

ResultString doTheWork() {
  ///...1
  ///...2
  ///...
  ///...4
  return ResultString('중요한 데이터');
}

ResultDouble doTheWork2() {
  ///...1
  ///...2
  ///...
  ///...4
  return ResultDouble('중요한 데이터');
}

/////////////////////////////////

/// Generic 사용 후

Result<String> doTheWork3() {
  ///...1
  ///...2
  ///...
  ///...4
  return Result('중요한 데이터');
}

/////////////////////////////////////////////////////

/// Method Generic
Result doTheWork4<Result extends Animal>(Result Function() animalCreator) {
  return animalCreator();
}

////////////////////////////////////////////////////////////////////////////

/// Future

Future<List> getTestList() async {
  await sleepAsync(Duration(seconds: 2));
  return testList;
}

/// nullable한 경우
// Future<List?> getTestList() async {
//   return null;
// }

/// 딜레이
Future sleepAsync(Duration duration) {
  return Future.delayed(duration, () => {});
}

/// FutureOr
abstract class goToWalkInterface {
  FutureOr<String> goToWalk();
}

class SyncWalk extends goToWalkInterface {
  @override
  String goToWalk() {
    // TODO: implement goToWalk
    throw UnimplementedError();
  }
}

class AsyncWalk extends goToWalkInterface {
  @override
  Future<String> goToWalk() async {
    // TODO: implement goToWalk
    throw UnimplementedError();
  }
}

////////////////////////////////////////////////////////////////////////////
/// Stream(Generator)

void addDataToTheSink(StreamController<int> controller) async{
  for(int i=1; i <= 4; i++){
    //print('before add sink');
    controller.sink.add(i);
    //print('after add sink');
    await sleepAsync(Duration(seconds: 1));
  }
}

Stream<int> countStream(int max) async* {
  for (int i = 1; i <= max; i++) {
    yield i;
    await sleepAsync(Duration(seconds: 1));
  }
}

// 에러용
Stream<int> countStreamForError(int max) async* {
  for (int i = 1; i <= max; i++) {
    if (i == 2){
      yield* Stream.error(Exception('에러발생'));
    }else {
    yield i;
    }
    await sleepAsync(Duration(seconds: 1));
  }
}

////////////////////////////////////////////////////////////////////////////
/// Iterable(Generator)

Iterable<String> makeIterable(int max) sync* {
  for (int i = 1; i <= max; i++) {
    // sleep은 현업에서 절대 쓰지 말것. 메인 쓰레드를 중지시킴.
    //sleep(Duration(seconds: 1));
    yield i.toString();
  }
  yield '완료되었습니다.';
}

Iterable<String> makeIterable2(int max) sync* {
  for (int i = 1; i <= max; i++) {
    // sleep은 현업에서 절대 쓰지 말것. 메인 쓰레드를 중지시킴.
    //sleep(Duration(seconds: 1));
    yield i.toString();
  }
  yield*  ['one' , 'two', 'three', 'four'];
  yield '완료되었습니다.';
}

/// Stream(Generator)
Stream<String> countStream2(int max) async* {
  for (int i = 1; i <= max; i++) {
    await sleepAsync(Duration(seconds: 1));
    yield i.toString();
  }
  yield '완료되었습니다.';
  yield* countStream2(max);
}
//*************************************************************************//

/// TestList
final testList = ['a', 'b', 'c', 'd', 'e', 'f', 'g'];

/// TestVocabulary
final testVocabulary = {
  'a': 'apple',
  'b': 'banana',
  'c': 'candy',
  'd': 'dream',
  'd': 'doll'
};

//*************************************************************************//

void practice1_Class() {
  /// class 예제 1

  final dog1 = Dog();
  final dog2 = Dog();
  final dog3 = Dog();

  final cat1 = Cat();
  final cat2 = Cat();
  final cat3 = Cat();

  final duck1 = Duck();

  final list = [dog1, dog2, dog3, cat1, cat2, cat3, duck1];

  /// 모든 dog, cat 호출하기

  for (final animal in list) {
    if (animal is Dog) {
      animal.walk();
    } else {
      (animal as Cat).walk();
    }

    animal.walk();
  }
}

void practice2_List() {
  /// List 아이템

  /// 삽입

  testList.insert(0, '알파벳');

  /// 삭제 후 삽입

  final item = testList.removeAt(7);
  testList.insert(1, item);

  /// 교환

  // final item2 = testList.last;
  // testList[7] = testList[1];
  // testList[1] = item2;

  /// 만든 swap Extension 사용하기

  testList.swap(7, 1);

  /// 변환

  final alphabets = testList.map((e) => e.toUpperCase());
  for (final alphabet in alphabets) {
    print(alphabet);
  }

  /// testList 출력

  // for (final alphabet in testList){
  //   print(alphabet);
  // }
}

void practice3_Map() {
  /// Map 만들기

  final vocabulary = HashMap<String, String>();

  vocabulary['a'] = 'apple';
  vocabulary['b'] = 'banana';
  vocabulary['c'] = 'candy';
  vocabulary['d'] = 'donut';
  vocabulary['e'] = 'easy';
  vocabulary['f'] = 'fun';
  vocabulary['g'] = 'great';

  print('--------------------------------------------------------------');

  /// Map 출력
  print(vocabulary);

  /// Map Key 출력
  print(vocabulary.keys);

  /// Map Value 출력
  print(vocabulary.values);

  print('--------------------------------------------------------------');

  final vocabulary2 = HashMap<String, String>();

  vocabulary2['h'] = 'hand';
  vocabulary2['i'] = 'icecream';
  vocabulary2['j'] = 'joy';

  /// map 합치기
  for (final voca in vocabulary2.entries) {
    vocabulary.putIfAbsent(voca.key, () => voca.value);
  }

  /// Map 출력
  print(vocabulary);

  /// Map Key 출력
  print(vocabulary.keys);

  /// Map Value 출력
  print(vocabulary.values);

  print('--------------------------------------------------------------');
}

void practice4_toSet() {
  /// toSet
  //이 반복 가능 항목과 동일한 요소를 포함하는 Set을 만듭니다.
  // iterable에 요소가 두 번 이상 포함되어 있거나 동일한 요소가 하나 이상 포함된 경우 집합에는 iterable보다 적은 수의 요소가 포함될 수 있습니다.
  // 세트의 요소 순서는 반복 가능한 요소의 순서와 동일 하다고 보장되지 않습니다.

  /// Map의 entries toSet()
  final uniqueAlphabet = testVocabulary.entries.toSet();

  /// Map의 entries toSet()
  final uniqueAlphabet2 = testVocabulary.keys.toSet();

  /// Map의 entries toSet()
  final uniqueAlphabet3 = testVocabulary.values.toSet();

  print(uniqueAlphabet);
  print(uniqueAlphabet2);
  print(uniqueAlphabet3);
}

void practice5_generic() {
  /// class generic
  final result = doTheWork();
  final result2 = doTheWork2();

  /// method or function generic
  final result3 = doTheWork4<Duck>(() => Duck());
  result3.walk();
}

void practice6_Future() async {
  /// Future의 기본 개념
  /// Future == 미래
  /// 시간이 걸리는 Computation 작업 또는 유저의 응답을 기다려야되는 상태

  /// Future의 생성과 수행
  // print('시작');
  // getTestList().then((value){
  //   print(value.toString());
  // });
  // final testlist = await getTestList();
  // print(testlist);
  // print('종료');

  /// Future Timeout
  // print('시작');
  // final testlist = getTestList().timeout(Duration(seconds: 1)).onError((error, stackTrace) => []);
  // print(testlist);
  // print('종료');

  /// Future Error handling
  print('시작');

  /// 첫 번째 방법
  // try {
  //   getTestList().timeout(Duration(seconds: 1));
  // }catch (e) {
  //   print(e);
  // }

  /// 두 번째 방법
  getTestList()
      .timeout(Duration(seconds: 1))
      .then((value) => print(value))
      .catchError((error, stackTrace) {
    print(error);
    print(stackTrace);
  });
  print('종료');

  /// FutureOr
}

void practice7_Stream() {
  /// Stream 기본 개념
  /// Future - 1번의 데이터를 가져옴
  /// Stream - 여러번의 데이터를 받을 수 있음

  /// Stream 생성과 수행
  /// 1. async*
  /// 2. streamController

  // [1,2,3,4,5,6,7,8,9,10].forEach((element){
  //   print(element);
  // });
  /// 위의 코드와 다른점은 딜레이 마다 데이터를 받아올 수 있다.
  // countStream(5).listen((event) {
  //   print(event);
  // });

  //final controller = StreamController<int>();

  //addDataToTheSink(controller);
  /// Stream 데이터 변환
  //countStream(4).map((event) => '$event 초가 지났습니다.').listen((event) { print(event); });

  /// Stream 데이터 관찰2 - BroadcastStream
  // final broadCastStream = countStream(4).asBroadcastStream();
  //
  // broadCastStream.listen((event) {
  //   print(event);
  // });
  //
  // Future.delayed(Duration(seconds: 2),(){
  //   broadCastStream.listen((event) {
  //     print('$event초 후 출력');
  //   });
  // });

  /// Stream Error Handling
//   countStreamForError(5).listen((event) {
//     print(event);
//   }).onError((e, trace){
//   print(e.toString());
//   });
// }

// 에러 무시하고 싶을 때 yield*
countStreamForError(5).listen((event) {
print(event);
},cancelOnError: false).onError((e, trace){
print(e.toString());
});
}

void practice8_Iterable() async{
  /// List와 Iterable
  final List list = ['blue' , 'yellow', 'red'];
  // final iterator = list.iterator;
  //
  // print(iterator.current);
  // while (iterator.moveNext()){
  // print(iterator.current);
  // };

  /// iterable은 순서가 있는 객체
  // list.forEach((element) {
  //   print(element);
  // });
  //
  // for(final color in list){
  //   print(color);
  // }

  /// sync*로 Iterable 만들기
  // for (final message in makeIterable(5)){
  //   print(message);
  // }

  /// async*로 Stream 만들기

  /// yield*를 통해서 Iterable & Stream 연장시키기
  // for (final message in makeIterable2(4)){
  //   print(message);
  // }

  await for (final message in countStream2(3)){
    print(message);
  }

}

main() {
  /// class practice
  //practice1_Class();

  /// list practice
  //practice2_List();

  /// map practice
  //practice3_Map();

  /// toSet practice
  //practice4_toSet();

  /// generic practice
  //practice5_generic();

  /// Future practice
  //practice6_Future();

  /// Stream practice
  //practice7_Stream();

  /// Iterable practice
  //practice8_Iterable();
}
