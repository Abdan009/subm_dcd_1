import 'package:flutter/material.dart';

import '../../common/enums.dart';
import '../api/api_service.dart';
import '../models/models.dart';

class DetailRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  DetailRestaurantProvider({required this.apiService});

  String _message = '';
  String get message => _message;
  late Restaurant _detailRestaurant;
  ResultState _detailRestaurantState =ResultState.loading;

  bool _isSliverAppBarExpanded = false;

  Restaurant get detailRestaurant => _detailRestaurant;
  ResultState get detailRestaurantState => _detailRestaurantState;

  bool get isSliverAppBarExpanded => _isSliverAppBarExpanded;

  set isSliverAppBarExpanded(bool value) {
    _isSliverAppBarExpanded = value;
    notifyListeners();
  }

  Future<dynamic> getDetailRestaurant(String id) async {
    try {
      _detailRestaurantState = ResultState.loading;
      final restaurant = await apiService.getDetailRestaurant(id);
      _detailRestaurantState = ResultState.hasData;
      notifyListeners();
      return _detailRestaurant = restaurant;
    } catch (e) {
      _detailRestaurantState = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
