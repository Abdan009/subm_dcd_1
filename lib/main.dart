import 'package:flutter/material.dart';
import 'package:restaurant_dicoding/common/styles.dart';
import 'package:restaurant_dicoding/presentation/ui/ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: primaryColor,
              secondary: secondaryColor,
            ),
        scaffoldBackgroundColor: primaryColor,
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
      routes: {
        RestaurantsUi.routeName: (context) => const RestaurantsUi(),
        DetailRestaurantUi.routeName: (context) =>
            (ModalRoute.of(context)?.settings.arguments is DetailRestaurantUi)
                ? ModalRoute.of(context)!.settings.arguments as Widget
                : const ParamNotFoundUi()
      },
    );
  }
}
