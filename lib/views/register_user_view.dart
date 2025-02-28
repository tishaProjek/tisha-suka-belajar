import 'package:flutter/material.dart';
import 'package:tokob_online/services/user.dart';
import 'package:tokob_online/views/login_view.dart';
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
  bool isPasswordVisiable = false;

  // Function untuk insert user
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
      if (result.status == true) {
        AlertMessage().showAlert(context, result.message, result.status);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginView()),
        );
      } else {
        AlertMessage().showAlert(context, result.message, result.status);
      }

      print(result.status);
      print(result.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registrasi Kesiapan Berteman Dengan Tisha"),
        backgroundColor: const Color(0xFFFF4800),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            children: [
              Text(
                "Registrasi nihbos",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: name,
                      decoration: InputDecoration(labelText: "Mau dipanggil siapa?"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'isi lah woy';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: email,
                      decoration: InputDecoration(labelText: "Minta email nya dong kak"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email harus diisi lahh';
                        }
                        return null;
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
                      hint: Text("Kita sebatas apa?"),
                      validator: (value) {
                        if (value == null || value.toString().isEmpty) {
                          return 'Role harus dipilih';
                        }
                        return null;
                      },
                    ),

                    TextFormField(
                      controller: address, 
                      decoration: InputDecoration(labelText: "Alamat tinggal di mana?"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Alamat wajib diisi';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: birthday, // Input tanggal lahir
                      decoration: InputDecoration(labelText: "Tanggal lahir (YYYY-MM-DD)"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Tanggal lahir wajib diisi';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: password,
                      decoration: InputDecoration(labelText: "Mau password kak"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Plis isi passwordnya';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    MaterialButton(
                      onPressed: insertUser,
                      child: Text("Sabmit"),
                      color: const Color(0xFFFF4800),
                    ),
                    SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: Text(
                        "Login sini nih",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 1, 21, 37),
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
