import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:quotes_app/models/quote_model.dart';

class QuoteProvider{

  String url = 'http://api.quotable.io/random';

  Future<Quote> getQuote() async {
    final response = await http.get( url );
    final decodedData = json.decode(response.body);

    final quote = new Quote.fromJson(decodedData);

    return quote;
  }

}