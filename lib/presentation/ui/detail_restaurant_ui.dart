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
  ScrollController _scrollController = ScrollController();
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
                        child: Container(
                          height: 100,
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
                                          .bodyText1!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
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
                                sizeIcon: 30,
                                titleStyle: textTheme(context).headline6,
                              ),
                            ],
                          ),
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
          padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
          children: [
            const SizedBox(
              height: 20,
            ),
            // Text(
            //   "Deskripsi",
            //   style: textTheme(context)
            //       .bodyText1!
            //       .copyWith(fontWeight: FontWeight.bold),
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            Text(
              widget.restaurant.description,
              style: textTheme(context).caption,
            ),
          ],
        ),
      ),
    );
  }
}
