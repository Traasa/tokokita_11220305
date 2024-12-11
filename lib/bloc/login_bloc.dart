// ignore: unused_import
import 'package:http/http.dart';
import 'package:tokokita/helpers/api.dart';
import 'package:tokokita/helpers/api_url.dart';
import 'package:tokokita/model/login.dart';

class LoginBloc {
  static Future<Login> login({
    String? email,
    String? password,
  }) async {
    String apiUrl = ApiUrl.login;

    var body = {
      "email": email,
      "password": password,
    };
    try {
      final response = await Api().post(apiUrl, body);

      // ignore: avoid_print
      print('Response JSON: $response');

      return Login.fromJson(response);
    } catch (error) {
      // ignore: avoid_print
      print('Error during login: $error');
      rethrow;
    }
  }
}
