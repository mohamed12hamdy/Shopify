import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopify/Login.dart';
import 'package:shopify/data_provider/remote/firebaseHelper.dart';
//import 'pages.dart';

class Register extends StatefulWidget {
  Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool scureText = true;
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final formkey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Center(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: SizedBox(
                height: screenHeight,
                width: screenWidth,
                child: Column(
                  children: [
                    Form(
                        key: formkey,
                        child: Column(
                          children: [
                            Container(
                              child: Text(
                                "shopify",
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 70,
                                    color: Theme.of(context).primaryColorDark),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              child: Text(
                                "Sign up now to gain sale%",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              controller: usernameController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "please enter username";
                                }
                              },
                              decoration: InputDecoration(
                                  labelText: "username",
                                  prefixIcon: Icon(Icons.person),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Theme.of(context).primaryColorDark),
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .primaryColorLight),
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  labelStyle: TextStyle(
                                      color:
                                          Theme.of(context).primaryColorDark),
                                  prefixIconColor:
                                      Theme.of(context).primaryColorDark),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                  labelText: "email",
                                  prefixIcon: Icon(Icons.email),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Theme.of(context).primaryColorDark),
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Theme.of(context).primaryColorDark),
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  labelStyle: TextStyle(
                                      color:
                                          Theme.of(context).primaryColorDark),
                                  prefixIconColor:
                                      Theme.of(context).primaryColorDark),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter password';
                                } else {
                                  if (!value!.contains("@")) {
                                    return "enter valid mail";
                                  }
                                }
                              },
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                                controller: passwordController,
                                obscureText: scureText,
                                enableSuggestions: false,
                                autocorrect: false,
                                decoration: InputDecoration(
                                  labelText: "password",
                                  prefixIcon: Icon(Icons.password),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        scureText = !scureText;
                                      });
                                    },
                                    icon: Icon(Icons.visibility),
                                    tooltip: 'Toggle Obscure Text',
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Theme.of(context).primaryColorDark),
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Theme.of(context).primaryColorDark),
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  labelStyle: TextStyle(
                                      color:
                                          Theme.of(context).primaryColorDark),
                                  prefixIconColor:
                                      Theme.of(context).primaryColorDark,
                                  suffixIconColor:
                                      Theme.of(context).primaryColorDark,
                                ),
                                validator: (value) {
                                  //RegExp regex = RegExp(
                                  //r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                                  if (value!.isEmpty) {
                                    return 'Please enter password';
                                  } else {
                                    return null;
                                  }
                                }),
                            SizedBox(
                              height: 30,
                            ),
                            SizedBox(
                              width: screenWidth * 4 / 5,
                              height: 50.0,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  primary: Theme.of(context)
                                      .primaryColorDark, // Background color
                                ),
                                onPressed: () {
                                  signUpParameter();
                                  // if (formkey.currentState!.validate()) {
                                  //   Navigator.pushReplacement(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //           builder: (context) => Login()));
                                  // }
                                },
                                child: Text(
                                  "Create Account",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signUpParameter() async {
    if (formkey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      final result = await FireBaseHelper()
          .SignUp(
        emailController.text.toString(),
        passwordController.text.toString(),
        usernameController.text.toString(),
      )
          .then((result) {
        if (result is User) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Login()),
          );
        } else if (result is String) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(result),
          ));
        }
      });

      // Navigator.pop(context); // Close the loading dialog

      // if (result is User) {
      //   Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(builder: (context) => HomePage()),
      //   );
      // } else if (result is String) {
      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //     content: Text(result),
      //   ));
      // }
    }
  }
}
