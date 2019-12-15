import 'dart:convert';
import 'package:crypto/crypto.dart';

String getSha1(String value, String secret) {
  var key = utf8.encode(secret);
  var bytes = utf8.encode(value);
  var hmacSha1 = new Hmac(sha1, key);
  var digest = hmacSha1.convert(bytes);
  return base64Encode(digest.bytes);
}
