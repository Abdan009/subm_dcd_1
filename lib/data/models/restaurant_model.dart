part of 'models.dart';

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String pictureLargeUrl;
  final String pictureMediumUrl;
  final String city;
  final double rating;
  final List<String> categories;
  final Menu? menus;
  final List<Review> reviews;
  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.pictureLargeUrl,
    required this.pictureMediumUrl,
    required this.city,
    required this.rating,
    this.categories = const [],
    required this.menus,
    this.reviews = const [],
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      pictureId: json["pictureId"],
      pictureLargeUrl: "$urlRestaurantPictureLarge/${json['pictureId']}",
      pictureMediumUrl: "$urlRestaurantPictureMedium/${json['pictureId']}",
      city: json["city"],
      rating: json["rating"]?.toDouble(),
      categories: (json["categories"] == null)
          ? []
          : (json["categories"] as Iterable)
              .map((e) => e['name'] as String)
              .toList(),
      menus: (json["menus"] == null) ? null : Menu.fromJson(json["menus"]),
      reviews: (json['customerReviews'] == null)
          ? []
          : (json['customerReviews'] as Iterable)
              .map((e) => Review.fromJson(e))
              .toList());
}
