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

////////////////////////////

abstract class PaymentService {
  void processPayment(){
    print('결제 시스템 작동 완료');
  }
}

class CreditCardPayment implements PaymentService {
  @override
  void processPayment() {
    print('카드 결제 완료!');
  }
}

class Order {
  PaymentService _paymentService;

  Order(this._paymentService);

  void checkout() {
    // 의존성 주입을 통해 PaymentService의 구체적인 인스턴스를 전달받습니다.
    _paymentService.processPayment();
    print('주문 완료');
  }
}