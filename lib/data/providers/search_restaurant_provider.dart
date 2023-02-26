import 'package:flutter/material.dart';
import 'package:restaurant_dicoding/data/api/api_service.dart';

import '../../common/enums.dart';
import '../models/models.dart';

class SearchRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  SearchRestaurantProvider({required this.apiService});

  List<Restaurant> _restaurants = [];
  ResultState _restaurantsState = ResultState.noData;
  String _message = 'Empty Data';

  String get message => _message;
  List<Restaurant> get restaurants => _restaurants;
  ResultState get restaurantsState => _restaurantsState;

  Future<dynamic> searchRestaurant(String query) async {
    try {
      if (query.trim() == '') {
        _restaurantsState = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      }
      _restaurantsState = ResultState.loading;
      notifyListeners();
      final restaurants = await apiService.searchDetailRestaurant(query);
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

  void clearState(){
    _restaurants = [];
    _message ='Empty Data';
    _restaurantsState =ResultState.noData;
  }
}
