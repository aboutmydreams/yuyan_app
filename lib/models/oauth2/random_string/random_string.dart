import 'dart:math';

String randomString(int stringLenth) {
  var randomString = "";
  var allString =
      "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
  var rng = new Random();
  for (var i = 0; i < stringLenth; i++) {
    randomString += allString[rng.nextInt(62)];
  }
  return randomString;
}

randomChoice(List list) {
  final _random = new Random();
  var element = list[_random.nextInt(list.length)];
  return element;
}
