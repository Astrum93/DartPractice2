class UserApi {
  final ConsoleLogger logger;

  UserApi(this.logger);

  void registerUser(String username, String password) {
    logger.log("User registered: $username", 1);
  }
}

class ConsoleLogger {
  @override
  void log(String message, int number) {
    print("LOG: $message");
  }
}

