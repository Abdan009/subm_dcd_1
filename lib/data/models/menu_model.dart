part of 'models.dart';

class Menu {
  final List<MenuItem> foods;
  final List<MenuItem> drinks;

  Menu({
     this.foods = const [],
     this.drinks  = const [],
  });

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        foods: List<MenuItem>.from(json["foods"].map((x) => MenuItem.fromJson(x, MenuItemType.food))),
        drinks: List<MenuItem>.from(json["drinks"].map((x) => MenuItem.fromJson(x, MenuItemType.drink))),
      );
}
