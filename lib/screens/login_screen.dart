import 'package:art_wave/utilities/text_field_widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:art_wave/utilities/show_error_dialog.dart';
import 'package:art_wave/constants/routes.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const LoginScreenWeb();
    } else {
      if (Platform.isAndroid) {
        return const LoginScreenAndroid();
      } else {
        return const Placeholder();
      }
    }
  }
}

class LoginScreenAndroid extends StatefulWidget {
  const LoginScreenAndroid({Key? key}) : super(key: key);

  @override
  State<LoginScreenAndroid> createState() => _LoginScreenAndroidState();
}

class _LoginScreenAndroidState extends State<LoginScreenAndroid> {
  late final TextEditingController emailController = TextEditingController();
  late final TextEditingController passwordController = TextEditingController();
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

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
          padding: const EdgeInsets.fromLTRB(50, 120, 50, 120),
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
                  child: const Text(
                    'Art Wave',
                    style: TextStyle(
                        color: Colors.deepOrangeAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Sign In',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  key: formKey,
                  child: textFieldWidget(
                    false,
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
                ElevatedButton(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.transparent),
                  ),
                  onPressed: () async {
                    try {
                      String email = emailController.text;
                      String password = passwordController.text;
                      final form = formKey.currentState!;
                      if (form.validate()) {}
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: email, password: password);
                      pushReplacementRoute(logicRoute);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        await showErrorDialog(context, 'User not found');
                      } else if (e.code == 'wrong-password') {
                        await showErrorDialog(context, 'Wrong password');
                      } else {
                        await showErrorDialog(context, 'Error: $e.code');
                      }
                    } catch (e) {
                      await showErrorDialog(context, e.toString());
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(
                        colors: [Colors.lightBlueAccent, Colors.orangeAccent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        "Sign In",
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
                      "Don't have an account?",
                      style: TextStyle(fontSize: 15),
                    ),
                    TextButton(
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 15),
                      ),
                      onPressed: () {
                        pushReplacementRoute(registerRoute);
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
                    style: TextStyle(fontSize: 15),
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

class LoginScreenWeb extends StatefulWidget {
  const LoginScreenWeb({Key? key}) : super(key: key);

  @override
  State<LoginScreenWeb> createState() => _LoginScreenWebState();
}

class _LoginScreenWebState extends State<LoginScreenWeb> {
  late final TextEditingController emailController = TextEditingController();
  late final TextEditingController passwordController = TextEditingController();
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

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Padding(
        padding: const EdgeInsets.all(100),
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
                      padding: const EdgeInsets.fromLTRB(10, 60, 10, 10),
                      child: const Text(
                        'Art Wave',
                        style: TextStyle(
                            color: Colors.deepOrangeAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        'Sign In',
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
                          String email = emailController.text;
                          String password = passwordController.text;
                          final form = formKey.currentState!;
                          if (form.validate()) {}
                          await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: email, password: password);
                          pushReplacementRoute(logicRoute);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            await showErrorDialog(context, 'User not found');
                          } else if (e.code == 'wrong-password') {
                            await showErrorDialog(context, 'Wrong password');
                          } else {
                            await showErrorDialog(context, 'Error: $e.code');
                          }
                        } catch (e) {
                          await showErrorDialog(context, e.toString());
                        }
                      },
                      child: Container(
                        width: 150,
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
                            "Sign In",
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
                          "Don't have an account?",
                          style: TextStyle(fontSize: 15),
                        ),
                        TextButton(
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                                fontSize: 15, color: Colors.lightBlueAccent),
                          ),
                          onPressed: () {
                            pushReplacementRoute(registerRoute);
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
                        style: TextStyle(
                            fontSize: 15, color: Colors.lightBlueAccent),
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
