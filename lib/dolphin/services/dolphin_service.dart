import 'dart:convert';
import 'package:http/http.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DolphinModel extends Equatable {
  // Equatable is designed to only work with immutable objects
  // so all member variables must be final
  final String id;
  final String regularLink;
  final Map urls;

  // create constant constructor
  const DolphinModel(
      {required this.id, required this.regularLink, required this.urls});

  // override method for equatable
  @override
  List<Object> get props => [
        {id, regularLink, urls}
      ];

  // create method to map values to properties
  factory DolphinModel.fromJson(Map<String, dynamic> json) {
    return DolphinModel(
        id: json['id'],
        regularLink: json['urls']['regular'],
        urls: json['urls']);
  }
}

class Urls {
  final String raw;
  final String full;
  final String regular;
  final String small;
  final String thumb;

  Urls(this.raw, this.full, this.regular, this.small, this.thumb);
}

class DolphinService {
  Uri endpoint = Uri.https('api.unsplash.com', '/photos/random', {
    'query': 'dolphin',
    'client_id': dotenv.env['CLIENT_ID'],
    // TODO: Make API call work with list of images
    // 'count': '1',
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

  Future<List<DolphinModel>> getDolphinImages() async {
    Response response = await get(endpoint);

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);

      return result.map(((e) => DolphinModel.fromJson(e))).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
