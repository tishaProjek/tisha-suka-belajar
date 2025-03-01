
import 'package:flutter/material.dart';
import 'package:tokob_online/models/user_login.dart';
import 'package:tokob_online/widgets/botton_nav.dart';
import 'package:tokob_online/views/register_user_view.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  UserLogin userLogin = UserLogin();
  String? nama;
  String? role;
  getUserLogin() async {
    var user = await userLogin.getUserLogin();
    if (user.status != false) {
      setState(() {
        nama = user.nama_user;
        role = user.role;
      });
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserLogin();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        backgroundColor: const Color.fromARGB(255, 255, 136, 0),
        foregroundColor: Colors.white,
        actions: [
  IconButton(
    onPressed: () {
      Navigator.popAndPushNamed(context, '/login');
      Navigator.popAndPushNamed(context, '/dasboard');
    },
    icon: Icon(Icons.logout),
  ),
],

      ),
      body: Center(child: Text("Selamat Datang Paduka $nama anda adalah $role")),
      bottomNavigationBar: BottomNav(0),
    );
  }
}

