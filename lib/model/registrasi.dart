class Registrasi {
  int? code;
  bool? status;
  String? data;

  Registrasi({this.code, this.status, this.data});

  factory Registrasi.fromJson(Map<String, dynamic> json) {
    return Registrasi(
        code: json['code'], status: json['status'], data: json['data']);
  }
}
