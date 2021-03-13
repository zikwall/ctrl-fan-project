import 'dart:convert';
import 'dart:io';

void CheckNetworkSource(String url) async {
  try {
    HttpClient _httpClient = HttpClient()
      ..connectionTimeout = const Duration(seconds: 5);
    final request = await _httpClient.getUrl(Uri.parse(url));

    final response = await request.close();
    var data = "";
    await response.transform(const Utf8Decoder()).listen((contents) {
      data += contents.toString();
    }).asFuture<String>();

    print("Data: " + data);
  } catch (exception) {
    print("Failed: $exception");
    return null;
  }
}