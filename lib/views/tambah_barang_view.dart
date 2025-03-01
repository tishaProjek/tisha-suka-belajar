import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tokob_online/widgets/alert.dart';
import 'package:tokob_online/views/tambah_barang_view.dart';
import 'package:tokob_online/views/barang_view.dart';
import 'package:tokob_online/models/barang_model.dart';
import 'package:tokob_online/services/barang.dart';


class TambahBarangView extends StatefulWidget {
  final String title;
  final BarangModel? item;

  const TambahBarangView(
      {super.key, required this.title, this.item, required String name});

  @override
  State<TambahBarangView> createState() => _TambahBarangViewState();
}

class _TambahBarangViewState extends State<TambahBarangView> {
  BarangService barang = BarangService();
  final formKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController description = TextEditingController();

  File? selectedImage;
  bool? isLoading = false;
  Future getImage() async {
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.item != null) {
      name.text = widget.item!.name!;
      price.text = widget.item!.price!.toString();
      description.text = widget.item!.description!;
      selectedImage = null;
    } else {
      name.clear();
      price.clear();
      description.clear();
      selectedImage = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: const Color.fromARGB(255, 251, 130, 253),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                    controller: name,
                    decoration: InputDecoration(label: Text("Title")),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'harus diisi';
                      } else {
                        return null;
                      }
                    }),
                TextFormField(
                    controller: price,
                    decoration: InputDecoration(label: Text("Vote Average")),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'harus diisi';
                      } else {
                        return null;
                      }
                    }),
                TextFormField(
                    controller: description,
                    decoration: InputDecoration(label: Text("Over View")),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'harus diisi';
                      } else {
                        return null;
                      }
                    }),
                TextButton(
                    onPressed: () {
                      getImage();
                    },
                    child: Text("Select Picture")),
                selectedImage != null
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        child: Image.file(selectedImage!),
                      )
                    : isLoading == true
                        ? CircularProgressIndicator()
                        : Center(child: Text("tolong get the image")),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 244, 144, 255),
                        foregroundColor: Colors.white),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        var data = {
                          "nama": name.text,
                          "harga": price.text,
                          "deskripsi": description.text,
                        };
                        var result;
                        if (widget.item != null) {
                          result = await barang.insertBarang(
                              data, selectedImage,
                              id: widget.item!.id.toString());
                        } else {
                          result =
                              await barang.insertBarang(data, selectedImage);
                        }

                        if (result.status == true) {
                          AlertMessage()
                              .showAlert(context, result.message, true);
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(context, '/barang');
                        } else {
                          AlertMessage()
                              .showAlert(context, result.message, false);
                        }
                      }
                    },
                    child: Text("Simpan"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
