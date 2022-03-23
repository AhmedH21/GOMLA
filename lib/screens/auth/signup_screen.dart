import 'package:ecom/provider/modal_hud.dart';
import 'package:ecom/screens/user/home_page.dart';
import 'package:ecom/screens/auth/login_screen.dart';
import 'package:ecom/services/auth.dart';
import 'package:ecom/widgets/custom_logo.dart';
import 'package:ecom/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class SignUpScreen extends StatefulWidget {
  static String id = "SignUpScreen";

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final auth = Auth();

  String name, email, password;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Container(
      decoration: backGroundImage("background"),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ModalProgressHUD(
          inAsyncCall: Provider.of<ModalHud>(context).isLoading,
          child: Form(
            key: _globalKey,
            child: ListView(
              children: [
                CustomLogo(),
                SizedBox(height: height * .09),
                CustomTextField(
                  onSaved: (value) {
                    name = value;
                  },
                  hint: "Enter your name",
                  icon: Icons.person,
                ),
                SizedBox(height: height * .02),
                CustomTextField(
                  onSaved: (value) {
                    email = value;
                  },
                  hint: "Enter your e-mail",
                  icon: Icons.mail,
                ),
                SizedBox(height: height * .02),
                CustomTextField(
                  onSaved: (value) {
                    password = value;
                  },
                  hint: "Enter your password",
                  icon: Icons.lock,
                ),
                SizedBox(height: height * .05),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 120),
                  child: Builder(
                    builder: (context) => TextButton(
                      onPressed: () async {
                        final modelHud =
                            Provider.of<ModalHud>(context, listen: false);
                        modelHud.changeIsLoading(true);
                        if (_globalKey.currentState.validate()) {
                          _globalKey.currentState.save();
                          try {
                            await auth.signUp(email, password);
                            modelHud.changeIsLoading(false);
                            Navigator.pushNamed(context, HomePage.id);
                          } on PlatformException catch (e) {
                            modelHud.changeIsLoading(false);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(e.message),
                              ),
                            );
                          }
                          modelHud.changeIsLoading(false);
                        }
                      },
                      child: Text(
                        'Sign Up',
                      ),
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height * .05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Do you have an account ?",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, LoginScreen.id);
                      },
                      child: Text(
                        "Sign-in",
                        style: TextStyle(color: kSecColor, fontSize: 16),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
