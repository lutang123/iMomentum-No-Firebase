import 'dart:convert';

import 'package:http/http.dart' as http;

class FetchQuote {
  /// Quote kindly supplied by https://theysaidso.com/api/
  Future<dynamic> fetchQuote() async {
    final response = await http.get('http://quotes.rest/qod.json');
    if (response.statusCode == 200) {
      return json.decode(response.body)['contents']['quotes'][0];
    } else {
      throw Exception('Failed to load location weather');
    }
  }
}

//'“The world breaks everyone and afterward many are strong at the broken places.” --Ernest Hemingway“'
