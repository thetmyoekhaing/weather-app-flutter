import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiModel {
  final String apiEndpoint;
  final bool? countries;
  final String? cityName;
  final String? units;
  final String? apiKey;

  ApiModel(
      {required this.apiEndpoint,
      this.countries,
      this.cityName,
      this.apiKey,
      this.units});

  Future<http.Response> fetchApi() async {
    final endpoint = apiEndpoint +
        (apiKey != null ? '$apiKey' : '') +
        (countries != null ? 'countries' : '') +
        (cityName != null ? '$cityName' : '') +
        (units != null ? '$units' : '');
    try {
      final response = await http.get(Uri.parse(endpoint));
      if (response.statusCode == 200) return response;
    } catch (e) {
      throw Exception(e);
    }
    return http.Response('', 404);
  }
}

class FetchApi {
  final String url;

  final String? apiKey;
  late ApiModel api;
  final String? cityName;
  final String? units;

  FetchApi({required this.url, this.cityName, this.apiKey, this.units}) {
    api = ApiModel(
        apiEndpoint: url, cityName: cityName, apiKey: apiKey, units: units);
  }

  Future<dynamic> fetchData() async {
    try {
      final response = await api.fetchApi();
      final data = jsonDecode(response.body.toString());
      if (data is Map) {
        print(data);
        return data;
      } else {
        throw Exception('Error fetching data: unexpected data type');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }
}
