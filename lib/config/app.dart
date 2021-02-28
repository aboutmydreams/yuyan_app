import 'package:yuyan_app/config/net/token.dart';

class App {
  static TokenHolder token = TokenHolder();

  static init() async {
    await token.ready;
  }
}
