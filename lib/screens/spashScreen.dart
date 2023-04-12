import 'package:flutter/material.dart';
import '../utils/apiClient.dart';
import '../utils/helper.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = "/splashScreen";
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

late String myToken;

class _SplashScreenState extends State<SplashScreen> {
  Future<void> setImpostazioni() async {
    await ApiClient().goToLogin(context);
  }

  @override
  void initState() {
    super.initState();
    setImpostazioni();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        width: Helper.getScreenWidth(context),
        height: Helper.getScreenHeight(context),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                Helper.getAssetName("logo.png", "virtual"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
