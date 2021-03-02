import 'package:yuyan_app/config/net/token.dart';

class App {
  static TokenProvider token = TokenProvider();

  static init() async {
    await token.ready;
  }
}
