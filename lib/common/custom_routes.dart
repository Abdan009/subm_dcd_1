import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_dicoding/data/providers/conectivity_provider.dart';
import 'package:restaurant_dicoding/presentation/ui/ui.dart';

class CustomRoute {
  static Route<dynamic> allRoutes(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) {
          final isOnline = Provider.of<ConnectivityProvider>(context).isOnline;
      if(!isOnline){
        return const NoConnectivityUi();
      }

      switch (settings.name) {
        case RestaurantsUi.routeName:
          return const RestaurantsUi();
        case DetailRestaurantUi.routeName:
          return settings.arguments is DetailRestaurantUi
                  ?settings.arguments as DetailRestaurantUi
                  : const ParamNotFoundUi();
        case SearchRestaurantUi.routeName:
          return const SearchRestaurantUi();
      }
       return const ParamNotFoundUi();
    });
  }
}
