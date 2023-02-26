import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_dicoding/common/custom_routes.dart';
import 'package:restaurant_dicoding/common/styles.dart';
import 'package:restaurant_dicoding/data/api/api_service.dart';
import 'package:restaurant_dicoding/data/providers/conectivity_provider.dart';
import 'package:restaurant_dicoding/data/providers/detail_restaurant_provider.dart';
import 'package:restaurant_dicoding/data/providers/search_restaurant_provider.dart';
import 'package:restaurant_dicoding/presentation/ui/ui.dart';

import 'data/providers/restaurant_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestaurantProvider>(
            create: (_) => RestaurantProvider(apiService: ApiService())),
        ChangeNotifierProvider<DetailRestaurantProvider>(
            create: (_) => DetailRestaurantProvider(apiService: ApiService())),
        ChangeNotifierProvider<ConnectivityProvider>(
            create: (_) => ConnectivityProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: primaryColor,
                secondary: secondaryColor,
              ),
          scaffoldBackgroundColor: secondaryColor,
          textTheme: myTextTheme,
          appBarTheme: const AppBarTheme(elevation: 0),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                textStyle: const TextStyle(),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5))),
          ),
        ),
        initialRoute: RestaurantsUi.routeName,
        onGenerateRoute: CustomRoute.allRoutes,
      ),
    );
  }
}
