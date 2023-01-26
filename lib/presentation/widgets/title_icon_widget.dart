part of 'widgets.dart';

class TitleIconWidget extends StatelessWidget {
  final BuildContext context;
  final String title;
  final IconData icon;
  final TextStyle? titleStyle;

  const TitleIconWidget(
    this.context, {
    Key? key,
    required this.title,
    required this.icon,
    this.titleStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: secondaryColor,
          size: 15,
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: Text(
            title,
            style: titleStyle ?? textTheme(context).caption,
          ),
        )
      ],
    );
  }
}
