import 'package:package_info/package_info.dart';
import 'package:yuyan_app/config/net/token.dart';

class App {
  static TokenProvider token = TokenProvider();
  static PackageInfo version;

  static init() async {
    await token.ready;
    version = await PackageInfo.fromPlatform();
  }
}
