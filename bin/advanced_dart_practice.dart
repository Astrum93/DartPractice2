import 'dart:collection';

import 'extention/collection_extention.dart';

/// Class

abstract class Animal {
  walk();
}

class Dog extends Animal{
  void walk(){
    print('Dog is walking');
  }
}

class Cat extends Animal{
  void walk(){
    print('Cat is walking');
  }
}

class Duck extends Animal{
  void walk() {
    print('Duck is walk');
  }
}


////////////////////////////////////////////////////////////////////////////

/// Generic Class

/// Generic 사용 전
class ResultString{
  final String data;

  ResultString(this.data);

}

class ResultDouble{
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


////////////////////////////////////////////////////////////////////////////

/// TestList
final testList = ['a', 'b', 'c', 'd', 'e', 'f', 'g'];

/// TestVocabulary
final testVocabulary = {'a': 'apple', 'b' : 'banana', 'c' : 'candy', 'd' : 'dream', 'd' : 'doll'};

////////////////////////////////////////////////////////////////////

void practice1_Class (){
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
    if(animal is Dog) {
      animal.walk();
    } else {
      (animal as Cat).walk();
    }

    animal.walk();
  }
}

void practice2_List(){
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

  testList.swap(7,1);

  /// 변환
  
  final alphabets = testList.map((e) => e.toUpperCase());
  for (final alphabet in alphabets){
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
  final uniqueAlphabet3= testVocabulary.values.toSet();

  print(uniqueAlphabet);
  print(uniqueAlphabet2);
  print(uniqueAlphabet3);
}

void practice5_generic(){
  /// class generic


  final result = doTheWork();
  /// method or function generic

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
  practice5_generic();
}