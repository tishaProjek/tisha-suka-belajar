import 'package:flutter/material.dart';
import 'package:tokob_online/services/user.dart';
import 'package:tokob_online/widgets/alert.dart';
import 'package:tokob_online/services/user.dart';
import 'package:tokob_online/widgets/alert.dart';
import 'package:tokob_online/views/register_user_view.dart';
import 'package:tokob_online/views/dasboard.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  UserService user = UserService();
  final formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLoading = false;
  bool showPass = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nih Login nya"),
        backgroundColor: const Color.fromARGB(255, 236, 125, 255),
        foregroundColor: const Color.fromARGB(255, 0, 0, 0),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/dashboard');
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            children: [
              Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: email,
                        decoration: InputDecoration(label: Text("Email")),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Email harus diisi';
                          } else {
                            return null;
                          }
                        },
                      ),
                      TextFormField(
                        controller: password,
                        obscureText: showPass,
                        decoration: InputDecoration(
                          label: Text("Password"),
                          suffix: IconButton(
                            onPressed: () {
                              setState(() {
                                showPass = !showPass;
                              });
                            },
                            icon: showPass
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password harus diisi';
                          } else {
                            return null;
                          }
                        },
                      ),
                      MaterialButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            setState(() {
                              isLoading = false;
                            });
                            var data = {
                              "email": email.text,
                              "password": password.text,
                            };
                            var result = await user.loginUser(data);
                            setState(() {
                              isLoading = true;
                            });
                            print(result.message);
                            print("Response Status: ${result.status}");
                            print("Response Message: ${result.message}");

                            if (result.status == true) {
                              AlertMessage()
                                  .showAlert(context, result.message, true);
                              print("Login status: ${result.status}");

                              Future.delayed(Duration(seconds: 1), () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DashboardView()),
                                );
                              });
                            } else {
                              AlertMessage()
                                  .showAlert(context, result.message, false);
                            }
                          }
                        },
                        child: isLoading ==false
                            ? Text("mASOk")
                            : CircularProgressIndicator(),
                        color: const Color.fromARGB(255, 255, 113, 217),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
