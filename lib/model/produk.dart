// ignore: unused_import
import 'dart:convert';

class Produk {
  int? id;
  String kodeProduk;
  String namaProduk;
  int hargaProduk;

  Produk({
    this.id,
    required this.kodeProduk,
    required this.namaProduk,
    required this.hargaProduk,
  });

  factory Produk.fromJson(Map<String, dynamic> json) {
    return Produk(
      id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
      kodeProduk: json['kode_produk'] ?? '',
      namaProduk: json['nama_produk'] ?? '',
      hargaProduk: json['harga'] != null
          ? int.tryParse(json['harga'].toString()) ?? 0
          : 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'kode_produk': kodeProduk,
      'nama_produk': namaProduk,
      'harga': hargaProduk,
    };
  }
}
