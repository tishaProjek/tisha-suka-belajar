import 'package:flutter/material.dart';
import 'package:tokob_online/views/barang_view.dart';
import 'package:tokob_online/views/dasboard.dart';
import 'package:tokob_online/views/login_view.dart';
import 'package:tokob_online/views/pesan_view.dart';
import 'package:tokob_online/views/register_user_view.dart';

void main() {
  runApp(MaterialApp(
    
    debugShowCheckedModeBanner: false,
    initialRoute: '/registrasi',
    routes: {
      '/registrasi': (context) => RegisterUserView(),
      '/login': (context) => LoginView(),
      '/dashboard': (context) => DashboardView(),
      '/barang': (context) => BarangView(),
      '/pesan': (context) => PesanView(),
    },
    
  ));
}
