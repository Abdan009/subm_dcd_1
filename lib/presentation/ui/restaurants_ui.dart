part of 'ui.dart';

class RestaurantsUi extends StatelessWidget {
  const RestaurantsUi({super.key});

  static const String routeName = "restaurant_ui";

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
              actions: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, SearchRestaurantUi.routeName);
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Icon(
                      Icons.search,
                      color: secondaryColor,
                    ),
                  ),
                )
              ],
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
                      style: textTheme(context).titleLarge?.copyWith(color: secondaryColor),
                    ),
                    Text(
                      "Recommended restaurant for you!",
                      style: textTheme(context).titleMedium?.copyWith(color: secondaryColor),
                    )
                  ],
                ),
              ),
            ),
          ];
        },
        body: Consumer<RestaurantProvider>(
          builder: (context, value, _) {
            if (value.restaurantsState == ResultState.loading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            } else if (value.restaurantsState == ResultState.error) {
              return Center(
                  child: Text(
                value.message,
                style: textTheme(context).bodyMedium,
              ));
            } else if (value.restaurantsState == ResultState.noData) {
              return Center(
                  child: Text(
                value.message,
                style: textTheme(context).bodyMedium,
              ));
            }
            return ListView(
              padding: const EdgeInsets.only(bottom: 40, top: 10),
              children: [
               const SizedBox(
                  height: 20,
                ),
                Column(
                  children: List.generate(
                    value.restaurants.length,
                    (index) => Builder(
                      builder: (context) {
                        Restaurant restaurantItem = value.restaurants[index];
                        return RestaurantItemWidget(
                            restaurantItem: restaurantItem);
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

