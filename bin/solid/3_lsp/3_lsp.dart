import 'package:meta/meta.dart';

class Rectangular2 {
  double height;
  double width;

  Rectangular2(this.width, this.height);

  @nonVirtual
  double getArea() {
    return height * width;
  }
}

class Square extends Rectangular2 {
  Square(double side) : super(side, side);

  @override
  set height(double height) {
    super.height = height;
    super.width = height;
  }

  @override
  set width(double width) {
    super.width = width;
    super.height = width;
  }

  @override
  double getArea() {
    return super.getArea();
  }
}

Rectangular2 getRectangular() => Square(10);

///////////////////

// 기반 클래스
class Shape {

  @nonVirtual
  double area() {
    return 0;
  }
}

// 서브 클래스
class Rectangle extends Shape {
  double width;
  double height;

  Rectangle(this.width, this.height);

  @override
  double area() {
    return width * height;
  }
}

class Triangle extends Shape {
  double base;
  double height;

  Triangle(this.base, this.height);

  @override
  double area() {
    return (base * height) / 2;
  }
}

void printArea(Shape shape) {
  print('Area: ${shape.area()}');
}
