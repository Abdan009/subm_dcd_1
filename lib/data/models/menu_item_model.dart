import '../../common/enums.dart';

class MenuItem {
  final String name;
  final MenuItemType type;

  MenuItem({required this.name, required this.type});

  factory MenuItem.fromJson(Map<String, dynamic> json, MenuItemType type) =>
      MenuItem(
        name: json["name"],
        type: type,
      );
}
