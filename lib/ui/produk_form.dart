import 'package:flutter/material.dart';
import 'package:tokokita/bloc/produk_bloc.dart';
import 'package:tokokita/model/produk.dart';
import 'package:tokokita/ui/produk_page.dart';
import 'package:tokokita/widget/warning_dialog.dart';

class ProdukForm extends StatefulWidget {
  final Produk? produk;

  const ProdukForm({super.key, this.produk});

  @override
  // ignore: library_private_types_in_public_api
  _ProdukFormState createState() => _ProdukFormState();
}

class _ProdukFormState extends State<ProdukForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH PRODUK";
  String tombolSubmit = "SIMPAN";

  final _kodeProdukTextboxController = TextEditingController();
  final _namaProdukTextboxController = TextEditingController();
  final _hargaProdukTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkUpdate();
  }

  void _checkUpdate() {
    if (widget.produk != null) {
      setState(() {
        judul = "UBAH PRODUK";
        tombolSubmit = "UBAH";
        _kodeProdukTextboxController.text = widget.produk!.kodeProduk!;
        _namaProdukTextboxController.text = widget.produk!.namaProduk!;
        _hargaProdukTextboxController.text =
            widget.produk!.hargaProduk.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(judul)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildTextField(
                  controller: _kodeProdukTextboxController,
                  label: "Kode Produk",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Kode Produk harus diisi";
                    }
                    return null;
                  },
                ),
                _buildTextField(
                  controller: _namaProdukTextboxController,
                  label: "Nama Produk",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Nama Produk harus diisi";
                    }
                    return null;
                  },
                ),
                _buildTextField(
                  controller: _hargaProdukTextboxController,
                  label: "Harga",
                  inputType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Harga harus diisi";
                    }
                    return null;
                  },
                ),
                _buildSubmitButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType inputType = TextInputType.text,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      keyboardType: inputType,
      validator: validator,
    );
  }

  Widget _buildSubmitButton() {
    return OutlinedButton(
      child: Text(tombolSubmit),
      onPressed: () {
        if (_formKey.currentState!.validate() && !_isLoading) {
          if (widget.produk != null) {
            // Kondisi update produk
            _ubahProduk();
          } else {
            // Kondisi tambah produk
            _simpanProduk();
          }
        }
      },
    );
  }

  void _simpanProduk() {
    setState(() {
      _isLoading = true;
    });

    Produk newProduk = Produk(
      id: null,
      kodeProduk: _kodeProdukTextboxController.text,
      namaProduk: _namaProdukTextboxController.text,
      hargaProduk: int.parse(_hargaProdukTextboxController.text),
    );

    ProdukBloc.addProduk(produk: newProduk).then(
      (value) {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const ProdukPage()),
        );
      },
      onError: (error) {
        showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (context) => const WarningDialog(
            description: "Simpan gagal, silahkan coba lagi",
          ),
        );
      },
    ).whenComplete(() {
      setState(() {
        _isLoading = false;
      });
    });
  }

  void _ubahProduk() {
    setState(() {
      _isLoading = true;
    });

    Produk updateProduk = Produk(id: widget.produk!.id);
    updateProduk.kodeProduk = _kodeProdukTextboxController.text;
    updateProduk.namaProduk = _namaProdukTextboxController.text;
    updateProduk.hargaProduk = int.parse(_hargaProdukTextboxController.text);

    ProdukBloc.updateProduk(produk: updateProduk).then((value) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const ProdukPage()),
      );
    }, onError: (error) {
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (context) => const WarningDialog(
          description: "Permintaan ubah data gagal, silahkan coba lagi",
        ),
      );
    }).whenComplete(() {
      setState(() {
        _isLoading = false;
      });
    });
  }
}
