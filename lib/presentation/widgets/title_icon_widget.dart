part of 'widgets.dart';

class TitleIconWidget extends StatelessWidget {
  final BuildContext context;
  final String title;
  final IconData icon;
  final TextStyle? titleStyle;
  final double sizeIcon;

  const TitleIconWidget(
    this.context, {
    Key? key,
    required this.title,
    required this.icon,
    this.titleStyle,
    this.sizeIcon =15
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: primaryColor,
          size: sizeIcon,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
            title,
            style: titleStyle ?? textTheme(context).bodySmall,
          ),
      ],
    );
  }
}
