import 'package:flutter/material.dart';
import 'package:tokob_online/widgets/alert.dart';
import 'package:tokob_online/services/user.dart';
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
      backgroundColor: const Color.fromARGB(255, 250, 240, 230),
      appBar: AppBar(
        title: Text("cIhUy Login"),
        backgroundColor: const Color.fromARGB(255, 255, 128, 0),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Text(
                          "Logistrasi sm Tisha",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        TextFormField(
                          controller: email,
                          decoration: InputDecoration(
                            labelText: "Email",
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'bagI lah Email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          controller: password,
                          obscureText: showPass,
                          decoration: InputDecoration(
                            labelText: "Password",
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  showPass = !showPass;
                                });
                              },
                              icon: Icon(showPass
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'password nyaaa ??hm';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });

                              var data = {
                                "email": email.text,
                                "password": password.text,
                              };

                              try {
                                var result = await user.loginUser(data);
                                setState(() {
                                  isLoading = false;
                                });
                                print("Response dari server: $result");

                                if (result.status == true) {
                                  AlertMessage().showAlert(context,
                                      "ASeqk ManTap berhasil uy!", true);
                                  Future.delayed(Duration(seconds: 2), () {
                                    Navigator.pushReplacementNamed(
                                        context, '/dashboard');
                                  });
                                } else {
                                  AlertMessage().showAlert(context,
                                      "kayaknya ada yg salah, coba", false);
                                }
                              } catch (e) {
                               
                                setState(() {
                                  isLoading = false;
                                });
                                AlertMessage().showAlert(
                                    context, "Kayaknya ada yg salah, hmm", false);
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 255, 140, 0),
                            shape: RoundedRectangleBorder(
                               ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 40, vertical: 15),
                          ),
                          child: isLoading
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text("LOGIN",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
