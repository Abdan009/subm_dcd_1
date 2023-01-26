part of 'ui.dart';

class ParamNotFoundUi extends StatelessWidget {
  const ParamNotFoundUi({super.key});

  @override
  Widget build(BuildContext context) {
    return const  Scaffold(
      body: Center(
        child: Text("Parameter Belum Terpasang"),
      ),
    );
  }
}