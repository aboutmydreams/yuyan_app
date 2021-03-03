import 'package:package_info/package_info.dart';

getVersion() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  String appName = packageInfo.appName;
  String packageName = packageInfo.packageName;
  String version = packageInfo.version;
  String buildNumber = packageInfo.buildNumber;
  print(appName);
  print(packageName);
  print(version);
  print(buildNumber);
  return version;
}
