import 'package:yuyan_app/models/oauth2/random_string/random_string.dart';

getTag() {
  String tag =
      randomString(5) + DateTime.now().microsecondsSinceEpoch.toString();
  return tag;
}
