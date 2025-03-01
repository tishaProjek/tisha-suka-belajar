import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tokob_online/models/response_data_list.dart';
import 'package:tokob_online/services/barang.dart';
import 'package:tokob_online/views/tambah_barang_view.dart';
import 'package:tokob_online/widgets/alert.dart';
import 'package:tokob_online/widgets/botton_nav.dart';

class BarangView extends StatefulWidget {
  const BarangView({super.key});

  @override
  State<BarangView> createState() => _BarangViewState();
}

class _BarangViewState extends State<BarangView> {
  BarangService barangService = BarangService();
  List action = ["Update", "Hapus"];
  List? barang;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TambahBarangView(
                              name: "Tambah Barang",
                              item: null,
                              title: 'Heqlloq',
                            )));
              },
              icon: Icon(Icons.add))
        ],
        title: Text("Barang"),
        backgroundColor: const Color.fromARGB(255, 255, 157, 0),
        foregroundColor: Colors.white,
      ),
      body: barang != null
          ? ListView.builder(
              itemCount: barang!.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: barang![index].posterPath != null
                        ? Image.network(barang![index].posterPath,
                            width: 50, height: 50, fit: BoxFit.cover)
                        : Icon(Icons.image),
                    trailing:
                        PopupMenuButton(itemBuilder: (BuildContext context) {
                      return action.map((r) {
                        return PopupMenuItem(
                            onTap: () {
                              Future.delayed(Duration.zero, () async {
                                if (r == "Update") {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TambahBarangView(
                                        name: "Update Barang",
                                        item: barang![index],
                                        title: '',
                                      ),
                                    ),
                                  );
                                } else {
                                  var results = await AlertMessage()
                                      .showAlertDialog(context);
                                  if (results != null &&
                                      results.containsKey('status')) {
                                    if (results['status'] == true) {
                                      print("Barang: $barang");
                                      print("Barang[index]: ${barang?[index]}");

                                      var res = await barangService.hapusBarang(barang![index].id);

                                      if (res.status == true) {
                                        AlertMessage().showAlert(
                                            context, res.message, true);
                                        getBarang();
                                      } else {
                                        AlertMessage().showAlert(
                                            context, res.message, false);
                                      }
                                    }
                                  }
                                }
                              });
                            },
                            value: r,
                            child: Text(r));
                      }).toList();
                    }),
                  ),
                );
              })
          : Center(
              child: CircularProgressIndicator(),
            ),
      bottomNavigationBar: BottomNav(1),
    );
  }

  getBarang() async {
    ResponseDataList getBarang = await barangService.getBarang();
    setState(() {
      barang = getBarang.data;
    });
  }
}
