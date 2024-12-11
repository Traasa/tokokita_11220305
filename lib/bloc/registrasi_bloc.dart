// ignore_for_file: unused_import

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:tokokita/helpers/api.dart';
import 'package:tokokita/helpers/api_url.dart';
import 'package:tokokita/model/registrasi.dart';

class RegistrasiBloc {
  static Future<Registrasi> registrasi({
    String? nama,
    String? email,
    String? password,
  }) async {
    String apiUrl = ApiUrl.registrasi;

    var body = {
      "nama": nama,
      "email": email,
      "password": password,
    };

    try {
      final response = await Api().post(apiUrl, body);

      if (kDebugMode) {
        print('Response body: $response');
      }

      if (response != null && response is Map<String, dynamic>) {
        if (response['code'] == 200 && response['status'] == true) {
          return Registrasi.fromJson(response);
        } else {
          throw Exception(response['data'] ?? 'Registrasi Gagal');
        }
      } else {
        throw Exception('Format respons tidak valid');
      }
    } catch (error) {
      throw Exception('Terjadi kesalahan: &error');
    }
  }
}
