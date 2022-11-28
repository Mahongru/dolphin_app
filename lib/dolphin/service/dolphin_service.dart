import 'dart:convert';
import 'package:http/http.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DolphinModel extends Equatable {
  final String url;
  const DolphinModel({required this.url});

  @override
  List<Object> get props => [
        {url}
      ];

  factory DolphinModel.fromJson(Map<String, dynamic> json) {
    return DolphinModel(url: json['urls']['small']);
  }
}

class DolphinService {
  Uri endpoint = Uri.https('api.unsplash.com', '/photos/random', {
    'query': 'dolphin',
    'client_id': dotenv.env['CLIENT_ID'],
    'orientation': 'squarish'
  });

  Future<DolphinModel> getDolphinImage() async {
    Response response = await get(endpoint);

    if (response.statusCode == 200) {
      final Map<String, dynamic> result = jsonDecode(response.body);

      return DolphinModel.fromJson(result);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
