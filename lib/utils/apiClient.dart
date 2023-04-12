import 'dart:async';
import 'package:beethree/utils/secureStorage.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../screens/loginScreen.dart';
import '../screens/homeScreen.dart';

class ApiClient {
  final Dio _dio = Dio();

  Future login(String email, String password, context) async {
    const baseurl = 'https://api.3bee.com/api/v1';

    var send = {
      'email': email,
      'password': password,
    };

    try {
      Response response =
          await _dio.post(baseurl + '/auth/jwt/create/', data: send);
      print(response.data);
      SecureStorage.saveData('access_token', response.data['access']);
      SecureStorage.saveData('refresh_token', response.data['refresh']);
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } on DioError catch (e) {}
  }

  Future getArnie() async {
    const baseurl = 'https://api.3bee.com/api/v1';
    String token = await getToken();
    try {
      Response response = await _dio.get(baseurl + '/apiaries/',
          options: Options(
            headers: {"Authorization": "Bearer " + token},
          ));

      return response.data;
    } on DioError catch (e) {
      return '0';
    }
  }

  //in use
  Future<void> goToLogin(context) async {
    Timer(Duration(milliseconds: 4000), () {
      Navigator.pop(context);

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    });
  }

  Future getToken() async {
    String key = 'access_token';
    return await returnKeyVal(key);
  }

  Future returnKeyVal(k) async {
    var q = await SecureStorage.readData(k);
    if (q == null) {
      q = '';
    }
    return q.toString();
  }
}
