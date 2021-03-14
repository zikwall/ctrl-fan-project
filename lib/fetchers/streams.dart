import 'dart:convert';
import 'package:http/http.dart' as http;

class Streams {
  final List<dynamic> channels;

  Streams({this.channels});

  factory Streams.fromJson(Map<String, dynamic> json) {
    return Streams(
      channels: json['channels'],
    );
  }
}

Future<Streams> fetchStreams() async {
  final client = http.Client();
  final queryParameters = {
    'grouped': '0',
    '_format': 'json',
  };
  final uri = Uri.http(
      'tv.zikwall.ru', '/api/ctrl/version-one/streams', queryParameters
  );

  try {
    final response = await http
        .get(uri)
        .timeout(Duration(seconds: 10));

    if (response.statusCode == 200) {
      return Streams.fromJson(json.decode(response.body));
    }
  } finally {
    client.close();
  }
}