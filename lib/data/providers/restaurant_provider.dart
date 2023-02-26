import 'package:flutter/material.dart';
import 'package:restaurant_dicoding/data/models/models.dart';

import '../../common/enums.dart';
import '../api/api_service.dart';

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    _getRestaurants();
  }

  late List<Restaurant> _restaurants;
  late ResultState _restaurantsState;
  String _message = '';

  String get message => _message;
  List<Restaurant> get restaurants => _restaurants;
  ResultState get restaurantsState => _restaurantsState;

  Future<dynamic> _getRestaurants() async {
    try {
      _restaurantsState = ResultState.loading;
      notifyListeners();
      final restaurants = await apiService.getRestaurants();
      if (restaurants.isEmpty) {
        _restaurantsState = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _restaurantsState = ResultState.hasData;
        notifyListeners();
        return _restaurants = restaurants;
      }
    } catch (e) {
      _restaurantsState = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
