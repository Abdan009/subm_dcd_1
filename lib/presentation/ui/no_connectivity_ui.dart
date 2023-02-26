part of 'ui.dart';

class NoConnectivityUi extends StatelessWidget {
  const NoConnectivityUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.portable_wifi_off,
              color: primaryColor,
              size: 80,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "No Connection",
              style: textTheme(context).titleLarge,
            ),
            Text("Please activate internet connection", style: textTheme(context).bodySmall,)
          ],
        ),
      ),
    );
  }
}
