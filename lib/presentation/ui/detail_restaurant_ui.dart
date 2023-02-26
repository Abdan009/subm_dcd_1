part of 'ui.dart';

class DetailRestaurantUi extends StatefulWidget {
  static const String routeName = "detail_restaurant";

  final Restaurant restaurant;
  const DetailRestaurantUi({
    super.key,
    required this.restaurant,
  });

  @override
  State<DetailRestaurantUi> createState() => _DetailRestaurantUiState();
}

class _DetailRestaurantUiState extends State<DetailRestaurantUi> {
  final ScrollController _scrollController = ScrollController();
  final kExpandedHeight = 300.0;
  @override
  void initState() {
    super.initState();
    Provider.of<DetailRestaurantProvider>(context, listen: false)
        .getDetailRestaurant(widget.restaurant.id);
    _scrollController.addListener(
      () {
        context.read<DetailRestaurantProvider>().isSliverAppBarExpanded =
            _scrollController.hasClients &&
                _scrollController.offset > kExpandedHeight - kToolbarHeight;
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DetailRestaurantProvider>(
        builder: (context, value, _) {
          if (value.detailRestaurantState == ResultState.loading) {
            return const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          } else if (value.detailRestaurantState == ResultState.error) {
            return Center(
                child: Text(
              value.message,
              style: textTheme(context).bodyMedium,
            ));
          } else if (value.detailRestaurantState == ResultState.noData) {
            return Center(
                child: Text(
              value.message,
              style: textTheme(context).bodyMedium,
            ));
          }
          Restaurant restaurant = value.detailRestaurant;
          return NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder: (context, isScrolled) {
              return [
                SliverAppBar(
                  backgroundColor: primaryColor,
                  pinned: true,
                  expandedHeight: kExpandedHeight,
                  toolbarHeight: 50,
                  title: (value.isSliverAppBarExpanded)
                      ? Text(
                          restaurant.name,
                          style: textTheme(context).titleMedium!.copyWith(
                              color: secondaryColor, fontWeight: FontWeight.w600),
                        )
                      : null,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.pin,
                    background: Container(
                      decoration: const BoxDecoration(color: secondaryColor),
                      child: Stack(
                        children: [
                          Hero(
                            tag: restaurant.pictureId,
                            child: Container(
                              height: 280,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(
                                      Colors.grey.withOpacity(0.5),
                                      BlendMode.dstATop),
                                  alignment: Alignment.topCenter,
                                  image:
                                      NetworkImage(restaurant.pictureLargeUrl),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 20),
                                  margin: const EdgeInsets.symmetric(
                                          horizontal: defaultMargin)
                                      .copyWith(bottom: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          offset: const Offset(0, 2),
                                          blurRadius: 4)
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              restaurant.name,
                                              style: textTheme(context)
                                                  .bodyMedium!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            TitleIconWidget(
                                              context,
                                              title: restaurant.city,
                                              icon: Icons.location_pin,
                                            ),
                                          ],
                                        ),
                                      ),
                                      TitleIconWidget(
                                        context,
                                        title: restaurant.rating.toString(),
                                        icon: Icons.star,
                                        sizeIcon: 20,
                                        titleStyle:
                                            textTheme(context).titleMedium,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ];
            },
            body: ListView(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: defaultMargin),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        restaurant.description,
                        style: textTheme(context).bodySmall,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Categories:",
                        style: textTheme(context).bodySmall?.copyWith(
                            fontWeight: FontWeight.w600, color: blackColor),
                      ),
                      Wrap(
                        spacing: 5,
                        runSpacing: 5,
                        children: List.generate(
                          restaurant.categories.length,
                          (index) => Text(
                            (index != restaurant.categories.length - 1)
                                ? "${restaurant.categories[index]},"
                                : restaurant.categories[index],
                            style: textTheme(context).bodySmall,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 30,
                  thickness: 2,
                  color: dividerColor,
                ),
                _ShowMenuWidget(
                    menuItems: restaurant.menus?.drinks ?? [],
                    type: MenuItemType.drink),
                _ShowMenuWidget(
                  menuItems: restaurant.menus?.foods ?? [],
                  type: MenuItemType.food,
                ),
                const Divider(
                  height: 30,
                  thickness: 4,
                  color: dividerColor,
                ),
                _CustomerReviewWidget(reviews: restaurant.reviews),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CustomerReviewWidget extends StatelessWidget {
  final List<Review> reviews;
  const _CustomerReviewWidget({
    super.key,
    required this.reviews,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Text(
            'Reviews',
            style: textTheme(context)
                .titleMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),

        Column(
          children: List.generate(
            reviews.length,
            (index) => ListTile(
              visualDensity: VisualDensity.compact,
              dense: true,
              leading:const CircleAvatar(
                backgroundColor: dividerColor,
                foregroundColor: primaryColor,
                child:  Icon(Icons.person_rounded,),
              ),
              minLeadingWidth: 20,
              
              title:Text(reviews[index].name, style: textTheme(context).titleSmall,),
              subtitle:Text(reviews[index].review, style: textTheme(context).bodySmall,) ,
              trailing:Text(reviews[index].date, style: textTheme(context).bodySmall,) ,
              
            ),
          ),
        ),
      ],
    );
  }
}

class _ShowMenuWidget extends StatelessWidget {
  final List<MenuItem> menuItems;
  final MenuItemType type;
  const _ShowMenuWidget({Key? key, required this.menuItems, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (menuItems.isEmpty)
        ? const SizedBox()
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      (type == MenuItemType.drink)
                          ? "Drinks"
                          : "Foods",
                      style: textTheme(context)
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    menuItems.length,
                    (index) => _manuItemWidget(
                      context,
                      image: (type == MenuItemType.drink)
                          ? 'assets/drink.png'
                          : 'assets/food.png',
                      nameItem: menuItems[index].name,
                    ),
                  ),
                ),
              ),
            ],
          );
  }

  Container _manuItemWidget(
    BuildContext context, {
    required String nameItem,
    required String image,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: widthLayout(context) / 4,
      constraints: const BoxConstraints(maxWidth: 100),
      margin: const EdgeInsets.only(right: 10, top: 10, bottom: 10),
      decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: const Offset(0, 0),
                blurRadius: 1)
          ]),
      child: Column(
        children: [
          SizedBox(
            height: 50,
            child: Image.asset(
              image,
              width: 30,
              height: 30,
            ),
          ),
          Text(
            nameItem,
            style: textTheme(context)
                .bodySmall!
                .copyWith(fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
