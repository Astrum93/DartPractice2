void main() {
  // todo2().listen((event) {});
}

/// Dart 기초 예제 연습2

/// 분기문과 반복문

/// 분기문 : 프로그램이 특정한 상황에 일을 할 지 / 하지 않고 넘길지
/// if / else || switch

/// if문 / if - else 문
///
/// if (조건식) {
///   조건식이 참일 경우 실행 할 코드
/// } else if (조건식2) {
///   맨 처음 조건식이 거짓이지만, 조건식2가 참일 경우 실행할 코드
/// } else {
///   조건식이 거짓일 경우 실행 할 코드
/// }
///

void ifTest() {
  bool isTrue = true;
  String text = 'Hello';
  bool trigger = 10 > 20;
  int standard = 3;

  if (isTrue) {
    print('True');
  }

  if (text == 'Hello') {
    print('True');
  }

  if (trigger) {
    print('True');
  } else {
    print('False');
  }

  if (standard < 0) {
    print('여기는 찍히지 않는다.');
  } else if (standard == 3) {
    print('여기는 찍힌다.');
  } else {
    print('모두 거짓~!');
  }
}

///////////////////////////////////////////////////////////////////////////////////////////

/// switch문
/// Flutter 3.10 / Dart 3.0 버전 이상부터 변경 된 부분이 조금 있는 문법 중 하나.
/// 일단 예시에서는 3.10 / 3.0 버전 기준으로 설명을 드리겠지만,
/// 중간중간에 구 버전 (3.7 버전 이하) 에서 사용하는 방법도
/// 같이 설명드릴 예정
///
/// switch (비교 대상) {
///   case (조건 식1) :
///     break;
///   case (조건 식2) :
///     return;
///   case (조건 식3) :
///   case (조건 식4) :
///   case (조건 식5) :
///   default :
/// }
///

void switchTest() {
  int num = 5;

  switch (num) {
    case 1:
      print('Switch $num');
    case 2:
      print('Switch $num');
    case 3:
      print('Switch $num');
    case 4:
      print('Switch $num');
    case 5:
      print('Switch $num');
      print('Answer!');
    case > 100:
      print('Wow big number!!');
    default:
      print('Not 1~5');
  }
}
///////////////////////////////////////////////////////////////////////////////////////////

/// 반복문 : 특정한 코드의 반복을 컴퓨터에게 지시 할 때 사용하는 프로그래밍 문법
/// for / for in / while / do - while
/// continue / break
///
/// for (기준 변수 ; 조건식; 가변치) {
///   조건식이 참 일 때 반복할 코드
/// }

void forTest() {
  for (int i = 0; i < 10; i++) {
    print('Running For Index $i');
  }
}

/// for (단일 변수 in 컬렉션 (List / Set / Map)) {
///   컬렉션 내에 요소들의 수 / 변수 만큼 사용 될 반복문
/// }

void forTest2() {
  List<int> indexs = [0, 1, 2, 3, 4, 5];
  for (final index in indexs) {
    print('Running For Index $index');
  }
}
///////////////////////////////////////////////////////////////////////////////////////////

/// while (조건식) {
///   조건식이 참일 경우 실행 될 반복문
/// }

void whileTest() {
  bool isRunning = true;
  int count = 0;

  while (isRunning) {
    if (count >= 5) {
      isRunning = false;
    }
    count++;
    print('While is $count Runnning~~~');
  }

  while (true) {
    if (count >= 5) {
      break;
    }
    count++;
    print('While is $count Runnning~~~');
  }
}
///////////////////////////////////////////////////////////////////////////////////////////

/// do - while
/// do {
///   선행 진행 / 반복 될 코드
/// } while (조건);

void dowhileTest() {
  int num = 0;

  do {
    num++;

    if (num == 4) {
      continue;
    }

    print('Running Do While $num');
  } while (num < 10);
}
///////////////////////////////////////////////////////////////////////////////////////////

/// 예외처리 : 프로그램이 진행 중일 때, 의도하였거나 / 의도하지 않은 상황에 대해서
/// 프로그램적으로 오류가 발생했을 때, 대처하는 방법.
/// try - catch문 : 가장 기본적인 예외처리문 / 많이 쓰이는 예외처리 문이기도 함.
/// finaly문
/// on문
/// throw / rethrow문

void trycatchTest() {
  try {
    /// 예외가 발생할 것으로 예상되는 코드
    print(10 ~/ 0);
  } catch (error, stack) {
    /// 예외가 발생했을 때 실행 하고자 하는 코드
    print(error);
    print(stack);
  } finally {
    /// 예외가 발생 했던, 하지 않았던, try 문 / catch 문 이후에 실행하고자 하는 코드
    print('예외처리 문을 지나쳤습니다.');
  }
  print('위의 에러 때문에 동작을 하지 않습니다.');
}

void trycatchonTest() {
  try {
    /// 예외가 발생할 것으로 예상되는 코드
    print(10 ~/ 0);
  } on UnsupportedError {
    print('~/ 해당 연산자는 0으로 나눌 수 없습니다.');
  } on TypeError {
    print('Null 값이 참조 되었습니다.');
  } catch (e) {
    print('모르는 에러가 발생했습니다.');
  }
  print('위의 에러 때문에 동작을 하지 않습니다.');
}

void trythrowoncatchrethrowTest() {
  try {
    /// 예외가 발생할 것으로 예상되는 코드
    throw Exception('Unkonwn Error');
  } on UnsupportedError {
    print('~/ 해당 연산자는 0으로 나눌 수 없습니다.');
  } on TypeError {
    print('Null 값이 참조 되었습니다.');
  } catch (e) {
    /// main() 밖으로 던져버리는 코드.
    rethrow;
  }
  print('위의 에러 때문에 동작을 하지 않습니다.');
}

///////////////////////////////////////////////////////////////////////////////////////////

/// 비동기 프로그래밍
/// 동기성 / 비동기성
/// 동기 : 모든 코드가 순차적으로 진행되는 형태
/// 비동기 : 코드가 동시다발적으로 실행되서, 순차적으로 보장을 할 수 없는 형태

/// async / await / Future : 1회만 응답을 돌려받는 경우

Future<void> todo(int second) async {
  await Future.delayed(Duration(seconds: second));
  print('Todo Done in $second second');
}

/// async* / yield /Stream : 지속적으로 응답을 돌려받는 경우

Stream<int> todo2() async* {
  int counter = 0;

  while (counter <= 10) {
    counter++;
    await Future.delayed(Duration(seconds: 1));
    print('Todo is Running $counter');
    yield counter;
  }

  print('Todo is Done');
}

///////////////////////////////////////////////////////////////////////////////////////////

