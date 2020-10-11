import 'dart:core';

String sortMap(Map query) {
  String signString = [
    'client_id',
    'code',
    'response_type',
    'scope',
    'timestamp',
  ].map((getKey) => "$getKey=${Uri.encodeComponent(query[getKey])}").join('&');
  return signString;
}

String sortSignMap(Map query) {
  String signString = [
    'client_id',
    'code',
    'response_type',
    'scope',
    'sign',
    'timestamp',
  ].map((getKey) => "$getKey=${Uri.encodeComponent(query[getKey])}").join('&');
  return signString;
}
