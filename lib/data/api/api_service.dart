import 'dart:convert';

import '../models/models.dart';
import 'package:http/http.dart' as http;

class ApiService{
  static const String _baseUrl = "https://restaurant-api.dicoding.dev";

  Future<List<Restaurant>> getRestaurants() async {
    final response = await http.get(Uri.parse("$_baseUrl/list"));
    if (response.statusCode == 200) {
      return (json.decode(response.body)['restaurants'] as Iterable).map((e) => Restaurant.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load Restaurans');
    }
  }

  Future<Restaurant> getDetailRestaurant(String id) async {
    final response = await http.get(Uri.parse("$_baseUrl/detail/$id"));
    if (response.statusCode == 200) {
      return Restaurant.fromJson(json.decode(response.body)['restaurant']);
    } else {
      throw Exception('Failed to load Restaurant');
    }
  }

   Future<List<Restaurant>> searchDetailRestaurant(String query) async {
    final response = await http.get(Uri.parse("$_baseUrl/search?q=$query"));
    if (response.statusCode == 200) {
      return (json.decode(response.body)['restaurants'] as Iterable).map((e) => Restaurant.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load Restaurants');
    }
  }
}