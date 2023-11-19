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