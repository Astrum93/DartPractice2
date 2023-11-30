
import '1_srp/srp_practice.dart';

abstract interface class CoreLocalRepositoryInterface {
  void save(UserContents contents);

  void modify(UserContents contents);
}

abstract interface class LocalRepositoryInterface extends CoreLocalRepositoryInterface {
  void sendLog(UserContents contents);

  void retrySave(UserContents contents);
}

class Repo1 implements LocalRepositoryInterface {
  @override
  void modify(UserContents contents) {}

  @override
  void retrySave(UserContents contents) {}

  @override
  void save(UserContents contents) {}

  @override
  void sendLog(UserContents contents) {}
}

class Repo2 implements CoreLocalRepositoryInterface {
  @override
  void modify(UserContents contents) {}

  @override
  void save(UserContents contents) {}
}

