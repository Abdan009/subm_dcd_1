part of 'ui.dart';

class SearchRestaurantUi extends StatefulWidget {
  static const String routeName = "search_restaurant_ui";

  const SearchRestaurantUi({super.key});

  @override
  State<SearchRestaurantUi> createState() => _SearchRestaurantUiState();
}

class _SearchRestaurantUiState extends State<SearchRestaurantUi> {
  final TextEditingController _searchController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<SearchRestaurantProvider>.value(
        value: SearchRestaurantProvider(apiService: ApiService()),
        builder: (context, child) {
         return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Search',
                  style: textTheme(context)
                      .headlineMedium
                      ?.copyWith(color: blackColor),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _searchController,
                  onChanged: (value){
                    Provider.of<SearchRestaurantProvider>(context, listen: false).searchRestaurant(value);
                  },
                  decoration: InputDecoration(
                    hintText: "Search restaurant..",
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    isDense: true,
                    prefixIcon: const Icon(Icons.search),
                    border:
                        OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Consumer<SearchRestaurantProvider>(
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
                          ),
                        );
                      } else if (value.restaurantsState == ResultState.noData) {
                        return Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.search_outlined,
                                color: primaryColor,
                                size: 60,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                value.message,
                                style: textTheme(context)
                                    .bodyMedium
                                    ?.copyWith(color: blackColor),
                              ),
                            ],
                          ),
                        );
                      }
                      List<Restaurant> restaurants = value.restaurants;
                      return ListView(
                        children: List.generate(
                          restaurants.length,
                          (index) => RestaurantItemWidget(
                            restaurantItem: restaurants[index],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
        },
      ),
    );
  }
}
