import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:todo_app_c11/core/page_route_names.dart';

import '../../core/firebase_utils.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isObscured = true;
  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context);
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFDFECDB),
        image: DecorationImage(
          image: AssetImage("assets/icons/Subtract.png"),
          scale: 0.8,
          fit: BoxFit.none,
          alignment: Alignment.topCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: const Text("Login"),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: mediaQuery.size.height * 0.2),
                Text(
                  "Welcome back",
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: emailController,
                  cursorColor: theme.primaryColor,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter your Email";
                    }
                    var regex = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                    );
                    if (!regex.hasMatch(value)) {
                      return "Invalid email";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    label: const Text("E-mail"),
                    hintText: "Enter your email address",
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: theme.primaryColor,
                        width: 2,
                      ),
                    ),
                    enabledBorder: const UnderlineInputBorder(),
                    suffixIcon: const Icon(Icons.email),
                  ),
                ),
                const SizedBox(height: 40),
                TextFormField(
                  controller: passwordController,
                  cursorColor: theme.primaryColor,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter your password";
                    }
                    return null;
                  },
                  obscureText: isObscured,
                  decoration: InputDecoration(
                    label: const Text("Password"),
                    hintText: "Enter your Password",
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: theme.primaryColor,
                        width: 2,
                      ),
                    ),
                    enabledBorder: const UnderlineInputBorder(),
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          isObscured = !isObscured;
                        });
                      },
                      child: Icon(
                        isObscured ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                      context,
                      PageRouteName.registration,
                    );
                  },
                  child: Text(
                    "Forgot Password?",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      FirebaseUtils.signIn(
                              emailController.text, passwordController.text)
                          .then((value) {
                        if (value) {
                          EasyLoading.dismiss();

                          Navigator.pushReplacementNamed(
                              context, PageRouteName.layout);
                        }
                      });
                    }
                  },
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 12,
                    ),
                    backgroundColor: theme.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Login",
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      const Icon(Icons.arrow_forward),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                      context,
                      PageRouteName.registration,
                    );
                  },
                  child: Text(
                    "Don't have an account? Register",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
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
