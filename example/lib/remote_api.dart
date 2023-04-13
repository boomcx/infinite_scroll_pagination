import 'dart:convert';
import 'dart:io';

import 'package:breaking_bapp/character_summary.dart';
import 'package:http/http.dart' as http;

// ignore: avoid_classes_with_only_static_members
class RemoteApi {
  static Future<List<CharacterSummary>> getCharacterList(
    int offset,
    int limit, {
    String? searchTerm,
  }) =>
      Future.delayed(Duration(milliseconds: 1500), () {
        return List.generate(
            limit,
            (index) => CharacterSummary(
                id: 'id',
                author: 'author',
                url:
                    'https://fastly.picsum.photos/id/275/200/200.jpg?hmac=rTtDDof8-XH1HHCkHvJYmlWJU81lIlFVqweHCDDrifQ'));
      });
  // http
  //     .get(
  //   _ApiUrlBuilder.characterList(offset, limit, searchTerm: searchTerm),
  // )
  //     .then((value) {
  //   return _parseItemListFromJsonArray(
  //     jsonDecode(value.body),
  //     (jsonObject) {
  //       return CharacterSummary.fromJson(jsonObject);
  //     },
  //   );
  // });

  // .mapFromResponse<List<CharacterSummary>, List<dynamic>>(
  //   (jsonArray) => _parseItemListFromJsonArray(
  //     jsonArray,
  //     (jsonObject) => CharacterSummary.fromJson(jsonObject),
  //   ),
  // );

  static List<T> _parseItemListFromJsonArray<T>(
    List<dynamic> jsonArray,
    T Function(dynamic object) mapper,
  ) =>
      jsonArray.map(mapper).toList();
}

class GenericHttpException implements Exception {}

class NoConnectionException implements Exception {}

// ignore: avoid_classes_with_only_static_members
class _ApiUrlBuilder {
  static const _baseUrl = 'https://picsum.photos/v2';
  static const _charactersResource = '/list';

  static Uri characterList(
    int page,
    int limit, {
    String? searchTerm,
  }) =>
      Uri.parse(
        '$_baseUrl$_charactersResource?'
        'offset=$page'
        '&limit=$limit'
        '${_buildSearchTermQuery(searchTerm)}',
      );

  static String _buildSearchTermQuery(String? searchTerm) =>
      searchTerm != null && searchTerm.isNotEmpty
          ? '&name=${searchTerm.replaceAll(' ', '+').toLowerCase()}'
          : '';
}

extension on Future<http.Response> {
  Future<R> mapFromResponse<R, T>(R Function(T) jsonParser) async {
    try {
      final response = await this;
      print(response.body);
      if (response.statusCode == 200) {
        return jsonParser(jsonDecode(response.body));
      } else {
        throw GenericHttpException();
      }
    } on SocketException {
      throw NoConnectionException();
    }
  }
}
