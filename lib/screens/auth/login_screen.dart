import 'package:ecom/constants.dart';
import 'package:ecom/provider/admin_mode.dart';
import 'package:ecom/provider/modal_hud.dart';
import 'package:ecom/screens/admin/admin_home.dart';
import 'package:ecom/screens/user/home_page.dart';
import 'package:ecom/screens/auth/signup_screen.dart';
import 'package:ecom/services/auth.dart';
import 'package:ecom/widgets/custom_logo.dart';
import 'package:ecom/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'LoginScreen';
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final auth = Auth();

  final adminPassword = 'admin123';

  String email, password;

  bool keepMeLoggedIn = false;

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
            key: widget.globalKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Welcome,',
                          style: TextStyle(fontSize: 30, color: Colors.white)),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, SignUpScreen.id);
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(fontSize: 18, color:kSecColor),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Sign in to Continue',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black45,
                    ),
                  ),
                  CustomLogo(),
                  SizedBox(height: height * .09),
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
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                            value: keepMeLoggedIn,
                            onChanged: (value) {
                              setState(() {
                                keepMeLoggedIn = value;
                              });
                            }),
                        Text(
                          "Remember me",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 120),
                    child: Builder(
                      builder: (context) => TextButton(
                        onPressed: () {
                          if (keepMeLoggedIn == true) {
                            keepUserLoggedIn();
                          }
                          _validate(context);
                        },
                        child: Text(
                          'Login',
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
                        "Don't have an account ?",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, SignUpScreen.id);
                        },
                        child: Text(
                          "Sign up",
                          style: TextStyle(color:kSecColor, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Provider.of<AdminMode>(context, listen: false)
                                .changeIsAdmin(true);
                          },
                          child: Text(
                            "I'm an admin",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Provider.of<AdminMode>(context).isAdmin
                                    ? Colors.black
                                    : Colors.white),
                          ),
                        ),
                        // SizedBox(
                        //   width: 15,
                        // ),
                        GestureDetector(
                          onTap: () {
                            Provider.of<AdminMode>(context, listen: false)
                                .changeIsAdmin(false);
                          },
                          child: Text(
                            "I'm an user",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Provider.of<AdminMode>(context).isAdmin
                                    ? Colors.white
                                    : Colors.black),
                          ),
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

  void validate(BuildContext context) async {
    final modalHud = Provider.of<ModalHud>(context, listen: false);
    modalHud.changeIsLoading(true);
    // to check the data not empty
    if (widget.globalKey.currentState.validate()) {
      widget.globalKey.currentState.save();

      // validate admin
      if (Provider.of<AdminMode>(context, listen: false).isAdmin) {
        if (password == adminPassword) {
          try {
            auth.signIn(email, password);
            Navigator.pushNamed(context, AdminPage.id);
          } catch (e) {
            modalHud.changeIsLoading(false);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(e.message),
              ),
            );
          }
        } else {
          modalHud.changeIsLoading(false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Something went wrong, please try again !'),
            ),
          );
        }
      } else {
        // validate user
        try {
          await auth.signIn(email, password);
          Navigator.pushNamed(context, HomePage.id);
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.message),
            ),
          );
        }
      }
    }
    modalHud.changeIsLoading(false);
  }

  void _validate(BuildContext context) async {
    final modelhud = Provider.of<ModalHud>(context, listen: false);
    modelhud.changeIsLoading(true);
    if (widget.globalKey.currentState.validate()) {
      widget.globalKey.currentState.save();
      if (Provider.of<AdminMode>(context, listen: false).isAdmin) {
        if (password == adminPassword) {
          try {
            await auth.signIn(email.trim(), password.trim());
            Navigator.pushNamed(context, AdminPage.id);
          } catch (e) {
            modelhud.changeIsLoading(false);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(e.message),
              ),
            );
          }
        } else {
          modelhud.changeIsLoading(false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Something went wrong !'),
            ),
          );
        }
      } else {
        try {
          await auth.signIn(email.trim(), password.trim());
          Navigator.pushNamed(context, HomePage.id);
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.message),
            ),
          );
        }
      }
    }
    modelhud.changeIsLoading(false);
  }

  void keepUserLoggedIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(kKeepMeLoggedIn, keepMeLoggedIn);
  }
}
