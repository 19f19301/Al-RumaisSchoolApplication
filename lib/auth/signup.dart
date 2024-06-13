import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school/moodels/button.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  DateTime dateTime = DateTime(2024, 2, 1, 10, 20);
  GlobalKey<FormState> formState = GlobalKey();
  bool _obscureText = true;
  String? _gender;
  Color? _radioColor;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  TextEditingController userName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();

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
                      child: Image.asset('assets/reading (1).png'),
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
                        "Please enter your details",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Full Name",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: userName,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'This field cannot be empty';
                          }
                        },
                        decoration: const InputDecoration(
                          hintText: "Jehad Hamed",
                          prefixIcon: Icon(
                            Icons.person,
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
                        "Email address",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: email,
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
                        controller: password,
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
                      const Text(
                        "Date of Birth",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey), // Add border
                          borderRadius:
                              BorderRadius.circular(15.0), // Add border radius
                        ),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 7,
                            ),
                            const Icon(
                              Icons.date_range,
                              color: Colors.red,
                              size: 30,
                            ),
                            CupertinoPageScaffold(
                                child: CupertinoButton(
                                    child: Text(
                                      '${dateTime.month} - ${dateTime.day} - ${dateTime.year}',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.grey[500]),
                                    ),
                                    onPressed: () {
                                      showCupertinoModalPopup(
                                          context: context,
                                          builder: ((context) => SizedBox(
                                                height: 250,
                                                child: CupertinoDatePicker(
                                                  backgroundColor:
                                                      Colors.amber[50],
                                                  initialDateTime: dateTime,
                                                  onDateTimeChanged:
                                                      (DateTime newTime) {
                                                    setState(() {
                                                      dateTime = newTime;
                                                    });
                                                  },
                                                  mode: CupertinoDatePickerMode
                                                      .date,
                                                ),
                                              )));
                                    })),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Gender",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Radio(
                            value: 'male',
                            groupValue: _gender,
                            activeColor: _radioColor,
                            onChanged: (value) {
                              setState(() {
                                _gender = value;
                                _radioColor = Colors.red;
                              });
                            },
                          ),
                          const Text(
                            'Male',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Radio(
                            value: 'female',
                            groupValue: _gender,
                            activeColor: _radioColor,
                            onChanged: (value) {
                              setState(() {
                                _gender = value;
                                _radioColor = Colors.red;
                              });
                            },
                          ),
                          const Text('Female',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red)),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Phone Number",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: phoneNumber,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Phone number can't be empty";
                          } else if (value.length < 8) {
                            return "Phone number must be 8 digit long.";
                          }
                        },
                        decoration: const InputDecoration(
                          hintText: "9876 5432",
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.red,
                            size: 30,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Button(
                          title: 'Sign Up',
                          onPressed: () async {
                            if (formState.currentState!.validate()) {
                              try {
                                final credential = await FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                  email: email.text,
                                  password: password.text,
                                );

                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(credential.user!.uid)
                                    .set({
                                  'id': credential.user!.uid,
                                  'full_name': userName.text,
                                  'email': email.text,
                                  'phone_number': phoneNumber.text,
                                  'birthday': dateTime,
                                  'gender': _gender,
                                });
                                await FirebaseFirestore.instance
                                    .collection('Attendance')
                                    .doc(credential.user!.uid)
                                    .set({
                                  'id': credential.user!.uid,
                                  'attendance': 0.0,
                                  'absence': 0.0,
                                });

                                // await FirebaseFirestore.instance
                                //     .collection('Attendance')
                                //     .doc(credential.user!.uid)
                                //     .set({
                                //   'id': credential.user!.uid,
                                //   'attendance': 0.0,
                                //   'absence': 0.0,
                                // });

                                await FirebaseFirestore.instance
                                    .collection('Marks')
                                    .doc(credential.user!.uid)
                                    .set({
                                  'id': credential.user!.uid,
                                  'Mathematics': 0.0,
                                  'English':0.0,
                                  'Arts': 0.0,
                                  'Technology': 0.0,
                                  'Biology':0.0,
                                  'Chemistry': 0.0,
                                  'Physics': 0.0,
                                 
                                });

                               

                                Navigator.of(context)
                                    .pushReplacementNamed('/signIn');
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'weak-password') {
                                  print('The password provided is too weak.');
                                } else if (e.code == 'email-already-in-use') {
                                  print(
                                      'The account already exists for that email.');
                                }
                              } catch (e) {
                                print(e);
                              }
                            } else {
                              print('Invalid Form');
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: InkWell(
                          onTap: () {
                            //Navigator.pushReplacementNamed(context, '/signUp');
                          },
                          child: const Text(
                            "Don't have an account",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          )),
    ));
  }
}
