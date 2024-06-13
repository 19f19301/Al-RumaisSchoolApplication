import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:school/moodels/button.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  GlobalKey<FormState> formState = GlobalKey();
  bool _obscureText = true;
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 200,
                      width: 200,
                      child: Image.asset('assets/reading.png'),
                    ),
                    const Text(
                      "Al-Rumais School",
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Welcome",
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: formState,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Please login with your information",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Email address",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _email,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'This field cannot be empty';
                          }
                        },
                        decoration: const InputDecoration(
                          hintText: "user@gmail.com",
                          prefixIcon: Icon(
                            Icons.mail,
                            color: Colors.red,
                            size: 30,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Password",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _password,
                        obscureText: _obscureText,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'This field cannot be empty';
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Hfm87640DR!",
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.red,
                            size: 30,
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            child: Icon(
                              _obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: const Text(
                              "Forgot your password?",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Button(
                          title: 'Sign In',
                          onPressed: () async {
                            try {
                              final credential = await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: _email.text,
                                      password: _password.text);
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  "/menu", (route) => false);
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                print('No user found for that email.');
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.error,
                                  animType: AnimType.rightSlide,
                                  headerAnimationLoop: false,
                                  title: 'user-not-found',
                                  desc:
                                      'No user found for that email',
                                ).show();

                                Future.delayed(const Duration(seconds: 3), () {
                                  Navigator.of(context).pop();
                                });
                              } else if (e.code == 'wrong-password') {
                                print('Wrong password provided for that user.');
                                  AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.error,
                                  animType: AnimType.rightSlide,
                                  headerAnimationLoop: false,
                                  title: 'wrong-password',
                                  desc:
                                      'Wrong password provided for that user.',
                                ).show();

                                Future.delayed(const Duration(seconds: 3), () {
                                  Navigator.of(context).pop();
                                });
                              }
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: InkWell(
                          onTap: () {
                            Navigator.pushReplacementNamed(context, '/signUp');
                          },
                          child: const Text(
                            "Don't have an account",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )),
    ));
  }
}
