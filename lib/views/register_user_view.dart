import 'package:flutter/material.dart';
import 'package:tokob_online/services/user.dart';
import 'package:tokob_online/widgets/alert.dart';

class RegisterUserView extends StatefulWidget {
  const RegisterUserView({super.key});

  @override
  State<RegisterUserView> createState() => _RegisterUserViewState();
}

class _RegisterUserViewState extends State<RegisterUserView> {
  final formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController birthday = TextEditingController();
  List roleChoice = ["admin", "user"];
  String? role;

  Future<void> insertUser() async {
    if (formKey.currentState!.validate()) {
      var data = {
        "name": name.text,
        "email": email.text,
        "role": role,
        "password": password.text,
        "address": address.text,
        "birthday": birthday.text,
      };

      var result = await UserService().registerUser(data);
      AlertMessage().showAlert(context, result.message, result.status);

      if (result.status) {
        // Jika berhasil, tunggu 2 detik lalu navigasi ke dashboard
        Future.delayed(Duration(seconds: 2), () {
          Navigator.pushReplacementNamed(context, '/dashboard');
        });
      } else {
        // Jika gagal, tampilkan snackbar
        ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(content: Text(result.message)),
);

      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Assalamu'alaikum Sahabat"),
        backgroundColor: Colors.orange,
        foregroundColor: const Color.fromARGB(255, 255, 248, 238),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Registrasi Kesiapan berteman dengan Tisha",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: name,
                  decoration: InputDecoration(label: Text("Nama")),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'nm harus diisi';
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  controller: email,
                  decoration: InputDecoration(label: Text("email")),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'woy harus diisi';
                    } else {
                      return null;
                    }
                  },
                ),
                DropdownButtonFormField(
                  isExpanded: true,
                  value: role,
                  items: roleChoice.map((r) {
                    return DropdownMenuItem(value: r, child: Text(r));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      role = value.toString();
                    });
                  },
                  hint: Text("Pilih Role"),
                  validator: (value) =>
                      value == null ? 'mauu jd apa sih?' : null,
                ),
                 TextFormField(
                  controller: password,
                  decoration: InputDecoration(label: Text("Password")),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password harus diisi';
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  controller: address,
                  decoration: InputDecoration(label: Text("Rumahnya di mn?")),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'rmh hrs diisi';
                    } else {
                      return null;
                    }
                  },
                ),
               
                TextFormField(
                  controller: birthday,
                  decoration: InputDecoration(label: Text("Tgl lair")),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'woy harus diisi';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: insertUser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text("mAntaP",
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
                SizedBox(height: 15),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Text("Atau udh punya akun?",
                      style: TextStyle(
                          fontSize: 15,
                          color: const Color.fromARGB(255, 4, 4, 4))),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
