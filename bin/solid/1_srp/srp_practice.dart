/// 블로그용 예시
class User{
  UserProfile userProfile;
  UserProperty userProperty;

  User(this.userProfile, {required this.userProperty});

}

class UserProfile {
  String firstName = '';
  String lastName = '';
  String profileUrl = '';
  String socialNetwork = '';
}

class UserProperty {
  int level = 10;
  int like = 20;
  int point = 0;
  int friendCount = 5000;
}

class UserContents {
  String title = '';
  String content = '';
  DateTime createdDate = DateTime.now();
  DateTime modifiedDate = DateTime.now();

  void setContent(String title, String content) {
    this.title = title;
    this.content = content;
  }
}

class UserLocalRepository {

  void save<T>(T contents){
    // 로컬
    // 서버
  }

  void modify<T>(T contents){}

  void remove<T>(T contents){}
}