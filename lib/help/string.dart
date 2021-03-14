import 'dart:convert';

String base64decode(String s) {
  Codec<String, String> stringToBase64 = utf8.fuse(base64);

  return stringToBase64.decode(s);
}