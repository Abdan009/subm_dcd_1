part of 'widgets.dart';

class RestaurantItemWidget extends StatelessWidget {
  const RestaurantItemWidget({
    Key? key,
    required this.restaurantItem,
  }) : super(key: key);

  final Restaurant restaurantItem;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                      restaurantItem.pictureMediumUrl,
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
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
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
                      titleStyle: textTheme(context).bodySmall!.copyWith(
                          fontWeight: FontWeight.bold, color: primaryColor),
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
