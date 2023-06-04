import 'package:art_wave/utilities/text_field_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:art_wave/utilities/show_error_dialog.dart';
import 'package:art_wave/constants/routes.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const RegisterScreenWeb();
    } else {
      if (Platform.isAndroid) {
        return const RegisterScreenAndroid();
      } else {
        return const Placeholder();
      }
    }
  }
}

class RegisterScreenAndroid extends StatefulWidget {
  const RegisterScreenAndroid({Key? key}) : super(key: key);

  @override
  State<RegisterScreenAndroid> createState() => _RegisterScreenAndroidState();
}

class _RegisterScreenAndroidState extends State<RegisterScreenAndroid> {
  final _firestore = FirebaseFirestore.instance;
  late final TextEditingController usernameController = TextEditingController();
  late final TextEditingController passwordController = TextEditingController();
  late final TextEditingController emailController = TextEditingController();
  String? gender;
  bool _isObscure = true;
  final formKey = GlobalKey<FormState>();

  void validator(emailController) =>
      emailController != null && !EmailValidator.validate(emailController)
          ? 'Enter a valid email'
          : null;

  void pushRoute(String route) {
    Navigator.pushNamed(context, route);
  }

  void pushReplacementRoute(String route) {
    Navigator.pushReplacementNamed(context, route);
  }

  Future<void> addUser(String email, String username) async {
    final CollectionReference users = _firestore.collection('users');
    await users.doc(email).set({
      'username': username,
      'email': email,
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/art.png"), fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 120, horizontal: 50),
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                  child: const Text(
                    'Art Wave',
                    style: TextStyle(
                        color: Colors.deepOrangeAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 30
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Create New Account',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Form(
                  key: formKey,
                  child: textFieldWidget(
                    true,
                    false,
                    true,
                    TextInputType.emailAddress,
                    emailController,
                    'Email',
                    Icons.email_outlined,
                    null,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                textFieldWidget(
                  false,
                  _isObscure,
                  false,
                  TextInputType.visiblePassword,
                  passwordController,
                  'Password',
                  Icons.lock_outlined,
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                    icon: Icon(_isObscure
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                textFieldWidget(
                  true,
                  false,
                  true,
                  TextInputType.text,
                  usernameController,
                  'Username',
                  Icons.person_outlined,
                  null,
                ),
                const SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.transparent),
                    shape:
                    MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    try {
                      String username = usernameController.text;
                      String email = emailController.text;
                      String password = passwordController.text;
                      final form = formKey.currentState!;
                      if (form.validate()) {}
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                          email: email, password: password);
                      addUser(email, username);
                      pushReplacementRoute(logicRoute);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        await showErrorDialog(context,
                            "Weak password : Password should be above 6 characters");
                      } else if (e.code == 'invalid-password') {
                        await showErrorDialog(
                            context, 'Invalid-password');
                      } else if (e.code == 'email-already-in-use') {
                        await showErrorDialog(context,
                            'Email belongs to other user: Register with a different email');
                      } else {
                        await showErrorDialog(context, 'Error: $e.code');
                      }
                    } on TypeError catch (e) {
                      await showErrorDialog(context, e.toString());
                    } catch (e) {
                      await showErrorDialog(context, e.toString());
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(
                        colors: [
                          Colors.lightBlueAccent,
                          Colors.orangeAccent
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        "Register",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "Already have an account?",
                      style: TextStyle(fontSize: 15),
                    ),
                    TextButton(
                      child: const Text(
                        'Sign In',
                        style: TextStyle(fontSize: 15, color: Colors.lightBlueAccent),
                      ),
                      onPressed: () {
                        pushReplacementRoute(loginRoute);
                      },
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    pushRoute(resetPasswordRoute);
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(fontSize: 15, color: Colors.lightBlueAccent),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class RegisterScreenWeb extends StatefulWidget {
  const RegisterScreenWeb({Key? key}) : super(key: key);

  @override
  State<RegisterScreenWeb> createState() => _RegisterScreenWebState();
}

class _RegisterScreenWebState extends State<RegisterScreenWeb> {
  final _firestore = FirebaseFirestore.instance;
  late final TextEditingController usernameController = TextEditingController();
  late final TextEditingController passwordController = TextEditingController();
  late final TextEditingController emailController = TextEditingController();
  String? gender;
  bool _isObscure = true;
  final formKey = GlobalKey<FormState>();

  void validator(emailController) =>
      emailController != null && !EmailValidator.validate(emailController)
          ? 'Enter a valid email'
          : null;

  void pushRoute(String route) {
    Navigator.pushNamed(context, route);
  }

  void pushReplacementRoute(String route) {
    Navigator.pushReplacementNamed(context, route);
  }

  Future<void> addUser(String email, String username) async {
    final CollectionReference users = _firestore.collection('users');
    await users.doc(email).set({
      'username': username,
      'email': email,
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Padding(
        padding: const EdgeInsets.all(85),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                color: Colors.white,
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.fromLTRB(10, 25, 10, 10),
                      child: const Text(
                        'Art Wave',
                        style: TextStyle(
                          color: Colors.deepOrangeAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 30
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        'Create New Account',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Form(
                      key: formKey,
                      child: textFieldWidget(
                        true,
                        false,
                        true,
                        TextInputType.emailAddress,
                        emailController,
                        'Email',
                        Icons.email_outlined,
                        null,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    textFieldWidget(
                      false,
                      _isObscure,
                      false,
                      TextInputType.visiblePassword,
                      passwordController,
                      'Password',
                      Icons.lock_outlined,
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                        icon: Icon(_isObscure
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    textFieldWidget(
                      true,
                      false,
                      true,
                      TextInputType.text,
                      usernameController,
                      'Username',
                      Icons.person_outlined,
                      null,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.transparent),
                          shape:
                          MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      onPressed: () async {
                        try {
                          String username = usernameController.text;
                          String email = emailController.text;
                          String password = passwordController.text;
                          final form = formKey.currentState!;
                          if (form.validate()) {}
                          await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                              email: email, password: password);
                          addUser(email, username);
                          pushReplacementRoute(logicRoute);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            await showErrorDialog(context,
                                "Weak password : Password should be above 6 characters");
                          } else if (e.code == 'invalid-password') {
                            await showErrorDialog(
                                context, 'Invalid-password');
                          } else if (e.code == 'email-already-in-use') {
                            await showErrorDialog(context,
                                'Email belongs to other user: Register with a different email');
                          } else {
                            await showErrorDialog(context, 'Error: $e.code');
                          }
                        } on TypeError catch (e) {
                          await showErrorDialog(context, e.toString());
                        } catch (e) {
                          await showErrorDialog(context, e.toString());
                        }
                      },
                      child: Container(
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(
                            colors: [
                              Colors.lightBlueAccent,
                              Colors.orangeAccent
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            "Register",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          "Already have an account?",
                          style: TextStyle(fontSize: 15),
                        ),
                        TextButton(
                          child: const Text(
                            'Sign In',
                            style: TextStyle(fontSize: 15, color: Colors.lightBlueAccent),
                          ),
                          onPressed: () {
                            pushReplacementRoute(loginRoute);
                          },
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        pushRoute(resetPasswordRoute);
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(fontSize: 15, color: Colors.lightBlueAccent),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: Image.asset(
                  'assets/art.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
