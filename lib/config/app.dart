import 'package:package_info/package_info.dart';
import 'package:yuyan_app/config/net/token.dart';
import 'package:yuyan_app/controller/global/organization_controller.dart';
import 'package:yuyan_app/controller/global/my_controller.dart';

class App {
  static TokenProvider tokenProvider = TokenProvider();
  static OrgSpaceProvider orgSpaceProvider = OrgSpaceProvider();
  static MyUserProvider user = MyUserProvider();

  static PackageInfo version;

  static init() async {
    version = await PackageInfo.fromPlatform();
  }
}
