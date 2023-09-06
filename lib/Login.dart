import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopify/Register.dart';
import 'package:shopify/data_provider/remote/firebaseHelper.dart';
import 'pages.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool scureText = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: screenHeight,
            width: screenWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                            "Login now",
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
                          controller: emailController,
                          decoration: InputDecoration(
                              labelText: "email",
                              prefixIcon: Icon(Icons.email),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColorDark),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColorLight),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              labelStyle: TextStyle(
                                  color: Theme.of(context).primaryColorDark),
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
                                    color: Theme.of(context).primaryColorDark),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColorLight),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              labelStyle: TextStyle(
                                  color: Theme.of(context).primaryColorDark),
                              prefixIconColor:
                                  Theme.of(context).primaryColorDark,
                              suffixIconColor:
                                  Theme.of(context).primaryColorDark,
                            ),
                            validator: (value) {
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
                                  borderRadius: BorderRadius.circular(20.0)),
                              primary: Theme.of(context)
                                  .primaryColorDark, // Background color
                            ),
                            onPressed: () {
                              SignInParamter();
                              // if (formkey.currentState!.validate()) {
                              //   Navigator.pushReplacement(
                              //       context,
                              //       MaterialPageRoute(
                              //           builder: (context) => Pages()));
                              // }
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 110),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Not a member ?',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    )),
                                SizedBox(width: 5),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Register()));
                                  },
                                  child: Text('Register now'),
                                  style: TextButton.styleFrom(
                                    primary: Theme.of(context).primaryColorDark,
                                  ),
                                )
                              ]),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void SignInParamter() async {
    if (formkey.currentState!.validate()) {
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
      FireBaseHelper()
          .SignIn(
        emailController.text.toString(),
        passwordController.text.toString(),
      )
          .then((value) {
        if (value is User) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Pages()));
        } else if (value is String) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(value),
          ));
        }
      });
    }
  }
}
