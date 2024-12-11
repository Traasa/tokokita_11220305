import 'dart:convert';
import 'package:tokokita/helpers/api.dart';
import 'package:tokokita/helpers/api_url.dart';
import 'package:tokokita/model/produk.dart';

class ProdukBloc {
  static Future<List<Produk>> getProduks() async {
    String apiUrl = ApiUrl.listProduk;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listProduk = (jsonObj as Map<String, dynamic>)['data'];
    List<Produk> produklist = [];
    for (int i = 0; i < listProduk.length; i++) {
      produklist.add(Produk.fromJson(listProduk[i]));
    }
    return produklist;
  }

  static Future<String> addProduk({required Produk produk}) async {
    String apiUrl = ApiUrl.createProduk;

    var body = {
      "kode_produk": produk.kodeProduk,
      "nama_produk": produk.namaProduk,
      "harga": produk.hargaProduk.toString(),
    };

    try {
      var response = await Api().post(apiUrl, body);

      var jsonObj = json.decode(response.body);

      return jsonObj['status'];
    } catch (e) {
      throw Exception('Error adding product: $e');
    }
  }

  static Future<String> updateProduk({required Produk produk}) async {
    if (produk.id == null) {
      throw Exception('Product ID is required for update');
    }
    String apiUrl = ApiUrl.updateProduk(produk.id!);

    // Prepare body for the PUT request
    var body = {
      "kode_produk": produk.kodeProduk,
      "nama_produk": produk.namaProduk,
      "harga": produk.hargaProduk.toString(),
    };

    try {
      // Print the body to check values
      // ignore: avoid_print
      print("Request Body for Update: ${body.toString()}");

      // Make POST request to update the product
      var response = await Api().post(apiUrl, body);

      // Decode the response body
      var jsonObj = json.decode(response.body);

      // Return the status from the response
      return jsonObj['status'];
    } catch (e) {
      throw Exception('Error updating product: $e');
    }
  }

  // Method to delete a product by its ID
  static Future<String> deleteProduk({required int id}) async {
    String apiUrl = ApiUrl.deleteProduk(id);

    try {
      // Make DELETE request to delete the product
      var response = await Api().delete(apiUrl);

      // Decode the response body
      var jsonObj = json.decode(response.body);

      // Return the data from the response
      return jsonObj['data'];
    } catch (e) {
      throw Exception('Error deleting product: $e');
    }
  }
}
