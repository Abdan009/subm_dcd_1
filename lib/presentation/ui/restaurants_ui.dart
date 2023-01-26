part of 'ui.dart';

class RestaurantsUi extends StatelessWidget {
  const RestaurantsUi({super.key});

  static String routeName = "restaurant_ui";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (_, isScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              expandedHeight: 110,
              toolbarHeight: 80,
              leadingWidth: 0,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                expandedTitleScale: 1.1,
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Restaurant",
                      style: textTheme(context).headline6,
                    ),
                    Text(
                      "Recommended restaurant for you!",
                      style: textTheme(context).subtitle1,
                    )
                  ],
                ),
              ),
            ),
          ];
        },
        body: FutureBuilder<String>(
            future: DefaultAssetBundle.of(context)
                .loadString('assets/local_restaurant.json'),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return const CircularProgressIndicator();
              }
              final List<Restaurant> restaurants =
                  Restaurant.parseRestaurant(snapshot.data);
              return ListView(
                padding: const EdgeInsets.only(bottom: 40, top: 10),
                children: [
                  Column(
                    children: List.generate(
                      restaurants.length,
                      (index) => Builder(builder: (context) {
                        Restaurant restaurantItem = restaurants[index];
                        return _RestaurantItemWidget(
                            restaurantItem: restaurantItem);
                      }),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}

class _RestaurantItemWidget extends StatelessWidget {
  const _RestaurantItemWidget({
    Key? key,
    required this.restaurantItem,
  }) : super(key: key);

  final Restaurant restaurantItem;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (widthLayout(context) * 0.25) / 1.2,
      child: MaterialButton(
        padding: const EdgeInsets.symmetric(horizontal: defaultMargin)
            .copyWith(bottom: 15),
        onPressed: () {
          Navigator.pushNamed(
            context,
            DetailRestaurantUi.routeName,
            arguments: DetailRestaurantUi(
              restaurant: restaurantItem,
            ),
          );
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: restaurantItem.pictureId,
              child: Container(
                width: widthLayout(context) * 0.25,
                constraints: const BoxConstraints(maxWidth: 300),
                child: AspectRatio(
                  aspectRatio: 1.2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      restaurantItem.pictureId,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        restaurantItem.name,
                        style: textTheme(context)
                            .bodyText1!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TitleIconWidget(
                        context,
                        title: restaurantItem.city,
                        icon: Icons.location_pin,
                      ),
                    ],
                  ),
                  TitleIconWidget(context,
                      title: restaurantItem.rating.toString(),
                      titleStyle: textTheme(context).caption!.copyWith(
                          fontWeight: FontWeight.bold, color: secondaryColor),
                      icon: Icons.star),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
