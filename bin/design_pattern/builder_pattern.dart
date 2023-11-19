// Flutter에서 가능하기 때문에 임시로 만든 클래스 (error 방지용)
class Color {}

// Flutter에서 가능하기 때문에 임시로 만든 클래스 (error 방지용)
class Text {
  final String text;


 Text(this.text, {required style});

}

// Flutter에서 가능하기 때문에 임시로 만든 함수 (error 방지용)
TextStyle({required double fontSize, Color? color}) {}

//////////////////////////////////////////////////////////

class TextWidgetBuilder {
  double fontSize = 14;
  Color? color;
  String text;

  TextWidgetBuilder(this.text);

  TextWidgetBuilder setFontSize(double value) {
    fontSize = value;
    return this;
  }

  TextWidgetBuilder setColor(Color value) {
    color = value;
    return this;
  }

  Text make() {
    return Text(
      text,
      style: TextStyle(fontSize: fontSize, color: color),
    );
  }
}
