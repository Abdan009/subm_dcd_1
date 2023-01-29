part of 'ui.dart';

class DetailRestaurantUi extends StatefulWidget {
  final Restaurant restaurant;
  const DetailRestaurantUi({
    super.key,
    required this.restaurant,
  });

  static String routeName = "detail_restaurant";

  @override
  State<DetailRestaurantUi> createState() => _DetailRestaurantUiState();
}

class _DetailRestaurantUiState extends State<DetailRestaurantUi> {
  final ScrollController _scrollController = ScrollController();
  final kExpandedHeight = 300.0;
  bool isSliverAppBarExpanded = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(
      () {
        setState(() {
          isSliverAppBarExpanded = _scrollController.hasClients &&
              _scrollController.offset > kExpandedHeight - kToolbarHeight;
        });
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
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, isScrolled) {
          return [
            SliverAppBar(
              backgroundColor: secondaryColor,
              pinned: true,
              expandedHeight: kExpandedHeight,
              toolbarHeight: 50,
              title: (isSliverAppBarExpanded)
                  ? Text(
                      widget.restaurant.name,
                      style: textTheme(context).subtitle1!.copyWith(
                          color: primaryColor, fontWeight: FontWeight.w600),
                    )
                  : null,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Container(
                  decoration: const BoxDecoration(color: primaryColor),
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          final snackBar = SnackBar(
                            content: const Text('Hi, I am a SnackBar!'),
                            backgroundColor: (Colors.black12),
                            action: SnackBarAction(
                              label: 'dismiss',
                              onPressed: () {},
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        child: Hero(
                          tag: widget.restaurant.pictureId,
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
                                    NetworkImage(widget.restaurant.pictureId),
                              ),
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
                                  ]),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          widget.restaurant.name,
                                          style: textTheme(context)
                                              .bodyText2!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        TitleIconWidget(
                                          context,
                                          title: widget.restaurant.city,
                                          icon: Icons.location_pin,
                                        ),
                                      ],
                                    ),
                                  ),
                                  TitleIconWidget(
                                    context,
                                    title: widget.restaurant.rating.toString(),
                                    icon: Icons.star,
                                    sizeIcon: 20,
                                    titleStyle: textTheme(context).subtitle1,
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
              padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
              child: Column(
                children: [
                  Text(
                    widget.restaurant.description,
                    style: textTheme(context).caption,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
            _ShowMenuWidget.drinksMenu(drinkMenu: widget.restaurant.menus.drinks),

            const SizedBox(
              height: 10,
            ),
            _ShowMenuWidget.foodMenu(foodMenu: widget.restaurant.menus.foods),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class _ShowMenuWidget extends StatelessWidget {
  List<Drink>? drinkMenu;
  List<Food>? foodMenu;
  _ShowMenuWidget({Key? key}) : super(key: key);

  _ShowMenuWidget.drinksMenu({
    required this.drinkMenu,
  });

  _ShowMenuWidget.foodMenu({
    required this.foodMenu,
  });

  @override
  Widget build(BuildContext context) {
    return (drinkMenu == null && foodMenu == null)
        ? const SizedBox()
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      (drinkMenu != null) ? "Menu Minuman" : "Menu Makanan",
                      style: textTheme(context)
                          .bodyText1!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Lihat semua >",
                        style: textTheme(context).button,
                      ),
                    )
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
                    (drinkMenu != null) ? drinkMenu!.length : foodMenu!.length,
                    (index) => _manuItemWidget(
                      context,
                      image: (drinkMenu != null)
                          ? 'assets/drink.png'
                          : 'assets/food.png',
                      nameItem: (drinkMenu != null)
                          ? drinkMenu![index].name
                          : foodMenu![index].name,
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
      // height: widthLayout(context) / 4,
      width: widthLayout(context) / 4,
      constraints: const BoxConstraints(maxWidth: 100),
      margin: const EdgeInsets.only(right: 10, top: 10, bottom: 10),
      decoration: BoxDecoration(
          color: primaryColor,
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
                .caption!
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
