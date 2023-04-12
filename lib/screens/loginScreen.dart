import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../utils/helper.dart';
import '../utils/apiClient.dart';
import '../widgets/customTextInput.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/loginScreen ";
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final ApiClient _apiClient = ApiClient();

  bool _loader = false;

  Future<void> setImpostazioni() async {
    bool loader = _loader;
    loader = true;

    if (mounted) {
      setState(() => _loader = loader);
    }
  }

  @override
  void initState() {
    super.initState();
    setImpostazioni();
  }

  Future<void> loginUsers(context) async {
    //get response from ApiClient

    await _apiClient.login(
        emailController.text, passwordController.text, context);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
    );
  }

  _body(context) {
    if (!_loader) {
      return Scaffold(
          body: Center(
        child: LoadingAnimationWidget.threeArchedCircle(
          color: Color.fromARGB(180, 250, 4, 4),
          size: 80,
        ),
      ));
    }

    if (_loader) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: Helper.getScreenHeight(context),
            width: Helper.getScreenWidth(context),
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 30,
                ),
                child: Column(
                  children: [
                    Text(
                      'LOGIN',
                      style: Helper.getTheme(context).titleMedium,
                    ),
                    Spacer(),
                    CustomTextControll(
                      hintText: 'USERNAME',
                      ctrl: emailController,
                    ),
                    Spacer(),
                    CustomTextControll(
                      hintText: 'PASSWORD',
                      ctrl: passwordController,
                      isPassword: true,
                    ),
                    Spacer(),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          loginUsers(context);
                        },
                        child: const Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
}
