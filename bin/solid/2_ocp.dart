/// Class를 추가할 때
abstract class Shape2 {
  double calculateArea();
}

class Rectangular extends Shape2 {
  double height;
  double width;

  Rectangular(this.width, this.height);

  @override
  double calculateArea() {
    return height * width;
  }
}

class Square extends Shape2 {
  double side;

  Square(this.side);

  @override
  double calculateArea() {
    return side * side;
  }
}

class Triangle2 extends Shape2 {
  double height;
  double width;

  Triangle2(this.width, this.height);

  @override
  double calculateArea() {
    return height * width / 2;
  }
}

/// Enum을 추가할 때
getFruit() {
  return Fruit.Apple;
}

enum Fruit {
  Apple("red"),
  Banna("yellow"),
  Grape("purple");

  final String color;

  const Fruit(this.color);
}



setUserLevel() {
  return UserLevel.User1;
}

enum UserLevel{
  User1(100), User2(113), User3(52);

  final int level;
  const UserLevel(this.level);
}