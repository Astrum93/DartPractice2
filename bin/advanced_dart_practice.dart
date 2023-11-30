import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'dart:isolate';
import 'dart:math';
import 'package:test/expect.dart';

import 'design_pattern/builder_pattern.dart';
import 'design_pattern/command_pattern.dart';
import 'design_pattern/factory_pattern.dart';
import 'design_pattern/singleton_pattern.dart';
import 'extention/collection_extention.dart';
import 'solid/1_srp/local_repository.dart';
import 'solid/1_srp/srp_practice.dart';
import 'solid/1_srp/todo_note.dart';
import 'solid/2_ocp.dart';
import 'solid/3_lsp/3_lsp.dart';
import 'solid/4_isp.dart';
import 'solid/5_dip.dart';

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
  return ResultString('중요한 result 데이터');
}

ResultDouble doTheWork2() {
  ///...1
  ///...2
  ///...
  ///...4
  return ResultDouble('중요한 result2 데이터');
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
    return 'SyncWalk 입니다.';
  }
}

class AsyncWalk extends goToWalkInterface {
  @override
  Future<String> goToWalk() async {
    return 'AsyncWalk 입니다.';
  }
}

////////////////////////////////////////////////////////////////////////////
/// Stream(Generator)

// Stream 생성
Stream<int> makeStream = Stream<int>.fromIterable([1, 2, 3, 4, 5]);

void addDataToTheSink(StreamController<int> controller) async {
  for (int i = 1; i <= 4; i++) {
    print('before add sink');
    controller.sink.add(i);
    print('after add sink');
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
Stream<int> makeErrorStream(int max) async* {
  for (int i = 1; i <= max; i++) {
    if (i == 2) {
      yield* Stream.error(Exception('에러발생'));
    } else {
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
  yield* ['one', 'two', 'three', 'four'];
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

////////////////////////////////////////////////////////////////////////////
/// Lamda

void run(int Function(int a, int b) add2, int a, int b) {
  final sum = add2(a, b);
  print(sum);
}

int Function(T, T) byIntField<T>(int Function(T func) fieldProvider,
        {bool reverse = false}) =>
    (T a, T b) {
      final fieldA = fieldProvider(a);
      final fieldB = fieldProvider(b);
      return reverse ? fieldA.compareTo(fieldB) : fieldB.compareTo(fieldA);
    };

class Robot {
  final int number;

  Robot(this.number);

  @override
  String toString() {
    // TODO: implement toString
    return "Robot 일련번호 : <$number>";
  }
}

////////////////////////////////////////////////////////////////////////////
/// Functional Programing

class UserInfo {
  final int id;
  final String name;
  final int xp;
  final String roll;

  UserInfo(this.id, this.name, this.xp, this.roll);
}

final moon = UserInfo(1, 'Moon', 20, '전사');
final sun = UserInfo(2, 'Sun', 40, '마법사');
final sky = UserInfo(3, 'Sky', 50, '도적');
final cloud = UserInfo(4, 'Cloud', 70, '궁수');
final rain = UserInfo(5, 'Rain', 90, '힐러');

final userInfos = [moon, sun, sky, cloud];

List<UserInfo> getUserInfos() {
  return userInfos;
}

String infoToName(info) => info.name;

/// 기타 함수형 프로그래밍

Iterable<T> runAll<T>(
    void Function(Iterable<T> value) doFunction, Iterable<T> next) {
  doFunction(next);
  return next;
}

Iterable<T> runEach<T>(void Function(T value) doFunction, Iterable<T> next) {
  for (final T item in next) {
    doFunction(item);
  }
  return next;
}

Function reduce =
    <E>(E Function(E value, E element) combine, Iterable<E> iterable) {
  Iterator<E> iterator = iterable.iterator;
  if (!iterator.moveNext()) {
    print('No Element');
  }
  E value = iterator.current;
  while (iterator.moveNext()) {
    value = combine(value, iterator.current);
  }
  return value;
};

int add(int a, int b) => a + b;

int multiply(int a, int b) => a * b;

/// 커리 F => 함수 자체를 쪼개주는 역할
/// final curryFunction = curry(F(a,b))
/// curryFunction(a)(b)
curry(Function f) => (a, {Iterable? args}) =>
    (args?.length ?? 0) > 1 ? f(a, args) : (b) => f(a, b);

/// fxDart
fxDart(List args) async {
  await reduce((a, f) async {
    if (a is Future) {
      return f(await a);
    }
    return f(a);
  }, args);
}

////////////////////////////////////////////////////////////////////////////
/// Dart OOP
/// 추상화
abstract class Poketmon {
  int level;

  Poketmon(this.level);

  void attack() {
    print('공격!');
  }
}

abstract mixin class Run {
  String leg = 'leg';

  void run() {
    print('성공적으로 도망쳤다.');
  }
}

abstract mixin class Eat {
  void eat() {
    print('냠냠 쩝쩝');
  }
}

abstract interface class Thunderbolt {
  int skillLevel = 0;
  // int get skillLevel;
  // set skillLevel(int value);

  thunderBolt(int bolt) {
    print('$bolt볼트 공격!!!!');
  }
}

abstract interface class SuperThunderbolt extends Thunderbolt {
  SuperThunderbolt();

  void superThunderBolt() {
    print('슈퍼 썬더 볼트~~~');
  }
}

class Pikachu extends Poketmon with Run, Eat implements Thunderbolt {
  Pikachu(super.level, this.skillLevel);

  /// abstract class Poketmon의 attack()
  @override
  void attack() {
    print('레벨 $level Pikachu가 공격 하였습니다.');
  }

  /// abstract mixin class Run의 run()
  @override
  void run() {
    print('레벨 $level Pikachu가 성공적으로 도망쳤습니다.');
  }

  /// abstract mixin class Eat의 eat()
  @override
  void eat() {
    print('레벨 $level Pikachu가 밥을 냠냠쩝쩝 맛있게 먹습니다.');
  }

  /// abstract interface class의 인스턴스들
  @override
  int skillLevel;

  @override
  thunderBolt(int bolt) {
    print('피카츄가 ${skillLevel}Lv $bolt만 볼트를 사용합니다.');
  }
}

class Raichu extends Poketmon{
  Raichu(super.level);

  @override
  void attack() {
    print('Raichu 공격');
  }
}

class Mew extends Poketmon{
  Mew(super.level);

  @override
  void attack() {
    print('Mew 공격');
  }
}

class Lugia extends Poketmon{
  Lugia(super.level);

  @override
  void attack() {
    print('Lugia 공격');
  }
}



/// 캡슐화
class Human {
  int _age;

  Human(this._age);

  int get age => _age;

  void addAge() {
    _age++;
  }
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
  // 이 반복 가능 항목과 동일한 요소를 포함하는 Set을 만듭니다.
  // iterable에 요소가 두 번 이상 포함되어 있거나 동일한 요소가 하나 이상 포함된 경우 집합에는 iterable보다 적은 수의 요소가 포함될 수 있습니다.
  // 세트의 요소 순서는 반복 가능한 요소의 순서와 동일 하다고 보장되지 않습니다.

  /// Map의 entries toSet()
  final uniqueAlphabet = testVocabulary.entries.toSet();

  /// Map의 keys toSet()
  final uniqueAlphabet2 = testVocabulary.keys.toSet();

  /// Map의 values toSet()
  final uniqueAlphabet3 = testVocabulary.values.toSet();

  print(uniqueAlphabet);
  print(uniqueAlphabet2);
  print(uniqueAlphabet3);
}

void practice5_generic() {
  /// class generic
  final result = doTheWork();
  final result2 = doTheWork2();
  print(result.data);
  print(result2.data);

  /// method or function generic
  final result3 = doTheWork4<Duck>(() => Duck());
  result3.walk();
}

void practice6_Future() async {
  /// Future의 기본 개념
  /// Future == 미래
  /// 시간이 걸리는 Computation 작업 또는 유저의 응답을 기다려야되는 상태

  /// Future의 생성과 수행
  //print('시작');
  // getTestList().then((value){
  //   print(value.toString());
  // });
  // final testlist = await getTestList();
  // print(testlist);
  // print('종료');

  /// Future Timeout
  // print('시작');
  // final testlist = await getTestList().timeout(Duration(seconds: 1)).onError((error, stackTrace) => []);
  // print('종료');

  /// Future Error handling
  //print('시작');

  /// 첫 번째 방법
  // try {
  //   await getTestList().timeout(Duration(seconds: 1));
  // }catch (e) {
  //   print(e);
  // }
  // print('종료');

  /// 두 번째 방법
  print('시작');
  await getTestList()
      .timeout(Duration(seconds: 1))
      .then((value) => print(value))
      .catchError((error) {
    print(error);
    print('에러 발생!!!');
  });
  print('종료');
}

void practice7_Stream() {
  /// Stream 기본 개념
  /// Future - 1번의 데이터를 가져옴
  /// Stream - 여러번의 데이터를 받을 수 있음

  /// Stream 생성과 수행
  /// 1. async*
  /// 2. streamController

  // makeStream.listen((data) {
  //   print('Received data: $data');
  // }, onDone: () {
  //   print('Stream completed');
  // }, onError: (error) {
  //   print('Error: $error');
  // });

  // [1,2,3,4,5,6,7,8,9,10].forEach((item){
  //   print(item);
  // });

  /// 위의 코드와 다른점은 딜레이 마다 데이터를 받아올 수 있다.
  // countStream(5).listen((event) {
  //   print(event);
  // });

  // final controller = StreamController<int>();
  // final stream = controller.stream;
  // addDataToTheSink(controller);

  /// StreamController의 sink를 이용한 이벤트 추가
  // controller.sink.add(1);
  // controller.sink.add(2);
  // controller.sink.add(3);

  /// Error 추가하기
  // controller.sink.addError('에러발생 에러발생!!!');

  ///StreamController 닫기
  // controller.sink.close();

  //stream.listen((event) { print(event);});

  /// Stream Subscription을 이용한 구독
  // controller.stream.listen(
  //       (data) {
  //     print('전달 받은 data : $data');
  //   },
  //   onError: (error) {
  //     print('에러가 발생했습니다. \n에러 내용은 : $error 입니다.');
  //   },
  //   onDone: () {
  //     print('Stream이 종료 되었습니다.');
  //   },
  // );

  /// Stream 데이터 변환
  //countStream(4).map((event) => '$event 초가 지났습니다.').listen((event) { print(event); });

  /// Stream 데이터 관찰2 - BroadcastStream
  // final broadCastStream = countStream(4).asBroadcastStream();
  //
  // broadCastStream.listen((event) {
  //   print('첫 번째 Stream 값은 $event 입니다.');
  // });
  // broadCastStream.listen((event) {
  //   print(' 두 번째 Stream 값은 ${event + event} 입니다.');
  // });

  // Future.delayed(Duration(seconds: 2),(){
  //   broadCastStream.listen((event) {
  //     print('$event초 후 출력');
  //   });
  // });

  /// Broadcast를 사용한 StreamController
  // final broadcastController = StreamController.broadcast();
  // final stream = broadcastController.stream;
  //
  // stream.listen((event) {print('event의 값은 $event입니다.');});
  // stream.listen((event2) {print('event2의 값은 ${event2 + event2}입니다.');});
  //
  // broadcastController.sink.add(10);
  // broadcastController.sink.add(100);

  /// Stream Error Handling
  // makeErrorStream(5).listen((event) {
  //   print(event);
  // }).onError((e, trace) {
  //   print(e.toString());
  // });

  /// 에러 무시하고 싶을 때 yield*
  // makeErrorStream(5).listen((event) {
  //   print(event);
  // }, cancelOnError: false).onError((e, trace) {
  //   print(e.toString());
  // });
}

void practice8_Iterable() async {
  /// List와 Iterable
  final List<String> list = ['a', 'b', 'c'];
  final Set<String> set = {'1' '2' '3'};
  final Map<String, String> map = {'1': 'a', '2': 'b', '3': 'c'};

  // print(list.runtimeType);
  // print(set.runtimeType);
  // print(map.runtimeType);

  final Iterable<String> iterableList = ['a', 'b', 'c'];
  final Iterable<String> iterableSet = {'1' '2' '3'};
  final Iterable<String> iterableMapKeys = map.keys;
  final Iterable<String> iterableMapValues = map.values;
  final Iterable<MapEntry<String, String>> iterableMapEntries = map.entries;

  // print(iterableList.iterator);
  // print(iterableSet.iterator);
  // print(iterableMapKeys.iterator);
  // print(iterableMapValues.iterator);
  // print(iterableMapEntries.iterator);

  final listIterator = list.iterator;
  final setIterator = set.iterator;
  final mapKeysIterator = map.keys.iterator;
  final mapValuesIterator = map.values.iterator;
  final mapEntriesIterator = map.entries.iterator;

  //print(listIterator);
  // print(setIterator);
  // print(mapKeysIterator);
  // print(mapValuesIterator);
  // print(mapEntriesIterator);

  // while (listIterator.moveNext()){
  // print(listIterator.current);
  // };

  /// Iterator 초기값 출력
  final List colors = ['blue', 'yellow', 'red'];
  // final colorsIterator = colors.iterator;
  //
  // print(colorsIterator.current);

  /// iterable은 순서가 있는 객체

  colors.forEach((element) {
    print(element);
  });

  print(' ');

  for (final color in colors) {
    print(color);
  }

  /// sync*로 Iterable 만들기
  // for (final message in makeIterable(5)){
  //   print(message);
  // }

  /// async*로 Stream 만들기

  /// yield*를 통해서 Iterable & Stream 연장시키기
  // for (final message in makeIterable2(4)){
  //   print(message);
  // }

  // await for (final message in countStream2(3)) {
  //   print(message);
  // }
}

void practice9_Lambda() {
  /// 람다의 표현 설명
  /// (int 파라미터1, String 파라미터2) => 반환값
  // int add(int a, int b) {
  //   return a + b;
  // }

  int add(int a, int b) => a + b;

  final add2 = (int a, int b) => a + b;

  /// 다양한 Lambda
  final add3 = (a) => (b) => a + b;
  final add4 = add3(2);
  print(add4(3));
  print(add3(2)(3));

  /// 람다의 특징 설명

  /// 1. 익명 : 이름을 지을 수 없다. (변수에 담을 수 있음)
  /// 2. 함수 : Class에 종속되지 않음 Class에 종속된것은 Method
  /// 3. 전달 : 1급 객체로서 함수 파라미터로 전달, 변수에 저장 가능
  /// 4. 간결성 : 익명 클래스처럼 많은 코드를 구현할 필요가 없다.

  /// List Sort 예제1
  // final list = [5,2,4,1,3];
  // list.sort((a, b) => a == b ? 0 : a > b ? 1 : -1);
  // print(list);

  /// List Sort 예제2
  final robotList = [
    Robot(1),
    Robot(2),
    Robot(3),
    Robot(4),
    Robot(5),
    Robot(6)
  ];
  robotList.sort(byIntField<Robot>((element) => element.number, reverse: true));
  print(robotList);
}

void practice10_Functional() async {
  /// Functional Programming

  /// 프로그래밍 방법을 부르는 이름들

  /// 절차적 프로그래밍 - 명령형 프로그래밍
  /// UserInfos => Users => Users.name => 출력
  final infos = getUserInfos();
  final list = <String>[];
  for (final info in infos) {
    list.add(info.name);
  }
  //print(list);

  /// 함수형 프로그래밍 - 선언형 프로그래밍
  // final nameList = getUserInfos().map((info) => info.name).toList();
  // final nameList = getUserInfos().map(infoToName).toList();
  // print(nameList);

  /// 기타 함수형 프로그래밍
  //runAll((value) => print(value), [1,2,3,4]);

  //runEach((value) => print(value), [1,2,3,4]);

  //print(reduce<int>(add, [1,2]));
  //print(reduce<int>(multiply, [1,3,4,5,6,7,7,8,99]));

  final curryMultiply = curry(multiply);
  //print(curryMultiply(2)(3));

  /// 구구단으로 응용 가능
  // final multiply2 = curryMultiply(2);
  // for (int i = 1; i < 10; i++ ){
  //   print('2 곱하기 $i 는 ${multiply2(i)}');
  // }
}

void practice11_DartCoreLib() {
  // String content = '동물들 : ';
  //
  // StringBuffer stringBuffer = StringBuffer(content);
  // stringBuffer.writeAll(['사자', '호랑이', '원숭이', '얼룩말'], ',');
  // print(stringBuffer.toString());

  final findNumberRegExp = RegExp(r'\d+');
  const exampleUriPath =
      'http://api.dart.dev/stable/3.0.6/dart-core-library.html?param1=good&param2=33&param3=22.4&color[]=red&color[]=blue&color[]=3';

  // final matches = findNumberRegExp.allMatches(exampleUriPath);
  // for (final match in matches) {
  //   final matchedString = exampleUriPath.substring(match.start, match.end);
  //   print(matchedString);
  // }

  // final findHashTagRegExp = RegExp(r'(#[\d|A-Za-z가-힣ㄱ-ㅎㅏ-ㅣ][^를 ]*)');
  // const hashContent = '문장에 #해를시 #태그를 찾아주세요. #플러터 #좋아유';
  //
  // final hashMatches = findHashTagRegExp.allMatches(hashContent);
  // for (final match in hashMatches) {
  //   final matchedString = hashContent.substring(match.start, match.end);
  //   print(matchedString);
  // }

  final uri = Uri.parse(exampleUriPath);
  final pathuri = Uri.parse(
      '?param1=good&param2=33&param3=22.4&color[]=red&color[]=blue&color[]=3');

  /// scheme은 :// 앞 부분
  print(uri.scheme);

  /// host는 ://부터 첫 번째 / 까지
  print(uri.host);

  /// path는 파라미터가 나오는 ?영역 전까지
  print(uri.path);

  for (final pathSegment in pathuri.pathSegments) {
    print(pathSegment);
  }

  final params = pathuri.queryParametersAll;
  final param4 = params['color[]'];
  print(param4);
}

void practice12_DartOOP() {
  /// 객체지향 프로그래밍(OOP)의 특징

  /// 1. 추상화 (Abstraction)
  ///  - Abstract Class (extends - only 1)
  ///   - Animal - age, eat()
  ///   - Dog, Cat
  ///
  ///  - Abstract mixin Class (with - n*)
  ///
  ///
  ///  - Abstract interface Class (implements - n*)
  ///
  ///

  // final pikachu = Pikachu(99,100);
  // pikachu.attack();
  // pikachu.run();
  // pikachu.eat();
  // pikachu.thunderBolt(100);

  /// 2. 상속 (Inheritance)
  ///  - Extends

  /// 3. 다형성 (Polymorphism)
  ///  - override
  ///  - implement

  /// 4. 캡슐화 (Encapsulation)
  ///  - private ( _ 언더스코어, 언더바)
  ///  - method
  ///  - get & set



  /// 5. KISS (Keep It Simple Stupid) :  "간단하게 유지하라 어리석게 하지 말고"
  /// 6. YAGNI (You Ain't Gonna Need It) : "너는 그것을 필요로 하지 않을 것이다."
  /// 7. DRY (Don't Repeat Yourself) : "반복적인 코딩은 하지마라"
}

void practice13_SOLIDPrinciple() {
  /// SOLID Principles

  /// SRP 단일 책임 원칙 (Single responsibility principle) : 한 클래스는 하나의 책임만 가져야 한다.
  /// Class or File 단위의 역할을 명확히 하자.
  ///  - Property 분리
  ///  - Method or Function 분리
  ///  HOW? Class나 File의 이름을 보고 결정

  ///  bin/solid/1_srp
  final todo = TodoNote();
  // final repository = LocalRepository();
  // todo.setContent('수학 과제', "p20 ~ p40를 공책에 작성");

  // repository.save(todo);
  // repository.modify();
  // repository.remove();

  // final contents = UserContents();
  // final repository = UserLocalRepository();
  // contents.setContent('오늘 날씨 맑음', "오늘 날씨 진짜 좋다!!");
  //
  // repository.save(contents);
  // repository.modify(contents);
  // repository.remove(contents);

  /// OCP 개방-폐쇄 원칙 (Open/closed principle) : “소프트웨어 요소는 확장에는 열려 있으나 변경에는 닫혀 있어야 한다.”
  /// Open for extension
  /// Closed for modification
  /// 기능, 코드 확장에는 열려있고 (Open for extension)
  /// 추가를 할때, 수정을 안해도 되는 설계 (Closed for modification)

  /// bin/solid/2_ocp.dart
  /// 1. Class를 추가할 때
  /// 2. Enum을 추가할 때
  // final Fruit fruit = getFruit();

  // String color = fruit.color;
  // print(color);

  // final UserLevel userLevel = setUserLevel();
  // int? level = userLevel.level;

  // switch(userLevel) {
  //   case UserLevel.User1 :
  //     level = 100;
  //   case UserLevel.User2 :
  //     level = 112;
  //   case UserLevel.User3 :
  //     level = 29;
  // }

  /// LSP 리스코프 치환 원칙 (Liskov substitution principle) : “프로그램의 객체는 프로그램의 정확성을 깨뜨리지 않으면서 하위 타입의 인스턴스로 바꿀 수 있어야 한다.” 계약에 의한 설계를 참고하라.
  /// "Subtype should behave like a supertype."
  /// 상속받은 Subtype은 Supertype의 동작 의도대로 수행되어야 한다.

  /// bin/solid/3_lsp
  // Rectangular2 rectangular = getRectangular();
  // rectangular.height = 40;
  //
  // print(rectangular.width);

  /// ISP 인터페이스 분리 원칙 (Interface segregation principle) : “특정 클라이언트를 위한 인터페이스 여러 개가 범용 인터페이스 하나보다 낫다.”
  /// 쪼개야하는 인터페이스는 분리하자.

  /// bin/solid/4_isp.dart
  // final todo = TodoNote();
  // todo.setContent('수학 과제', "p20 ~ p40를 공책에 작성");
  //
  // final repo = Repo1();
  // repo.save(todo);
  // repo.modify(todo);

  /// DIP 의존관계 역전 원칙 (Dependency inversion principle) : 프로그래머는 “추상화에 의존해야지, 구체화에 의존하면 안된다.” 의존성 주입은 이 원칙을 따르는 방법 중 하나다.
  /// 직접적인 참조 대신 Abstract 참조를 사용하라

  /// bin/solid/5_dip.dart
  // final api = UserApi(ConsoleLogger());
  // api.registerUser("홍길동", "abc123*");
}

void practice14_DesignPattern() {
  /// Design Pattern의 장점
  ///  1. 유지보수를 용이
  ///  2. 확장성과 유연성을 제공
  ///  3. 코드 재사용
  ///  4. 코드 품질 향상
  ///  5. Dart뿐 아니라 다른 언어에서도 같은 이름/방식이 사용됨
  ///
  /// Design Pattern의 단점
  ///  1. 러닝 커브가 존재 (학습 필요)
  ///  2. 오히려 복잡해지거나 초반 개발시간이 늘어날 수 있음
  ///
  /// Design Pattern 추천 사이트
  /// https://github.com/kamranahmedse/design-patterns-for-humans

  /// Singleton Pattern
  /// 어플리케이션 개발 중 하나의 객체만 유지하고 싶을 경우 사용
  // final object1 = SingletonObject();
  // object1.count = 100;
  // final object2 = SingletonObject();
  // final object3 = SingletonObject.instance;
  //
  // // print(object1 == object2);
  // // print(object2 == object3);
  // // print(object1 == object3);
  // print(object3.count);

  SingletonObject objectFromAnotherWorld = SingletonObject.instance;

  /// Isolate에서 넘어온 Singleton 변수는 다른 Singleton 변수다.
  Isolate.run(() {
    final isolateObject = SingletonObject();
    final isolateObject2 = SingletonObject();
    print(isolateObject == isolateObject2);
    print(isolateObject == objectFromAnotherWorld);
  });

  /// Factory Pattern
  final FoodFactory factory = getFactory();
  final Food food = factory.createFood();
  print(food.createFlavor().taste);

  /// Command Pattern
  final Command selectedCommand = SaveCommand();
  selectedCommand.execute();

  /// Builder Pattern
  //final textWidget = TextWidgetBuilder('연습').setFontSize(14).setColor(Colors.blue).make();
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
  // practice7_Stream();

  /// Iterable practice
  // practice8_Iterable();

  /// Lamda practice
  //practice9_Lambda();

  /// Functional practice
  //practice10_Functional();

  /// Dart Core Libraries practice
  //practice11_DartCoreLib();

  /// Dart OOP practice
  // practice12_DartOOP();

  /// Dart SOLID Principle practice
  practice13_SOLIDPrinciple();

  /// Dart Design Pattern practice
  //practice14_DesignPattern();
}
