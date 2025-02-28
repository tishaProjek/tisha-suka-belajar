import 'package:flutter/material.dart';
import 'package:tokob_online/widgets/botton_nav.dart';


//hanya bisa di akses pelanggan
class PesanView extends StatefulWidget {
  const PesanView({super.key});


  @override
  State<PesanView> createState() => _PesanViewState();
}


class _PesanViewState extends State<PesanView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pesan"),
        backgroundColor: const Color.fromARGB(255, 255, 121, 253),
        foregroundColor: Colors.white,
      ),
      body: Text("Pesan"),
      bottomNavigationBar: BottomNav(1),
    );
  }
}
