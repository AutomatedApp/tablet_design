import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tablet_design/core/utils/app_colors.dart';
import 'package:tablet_design/core/utils/app_images.dart';
import 'package:tablet_design/core/utils/app_strings.dart';
import 'package:tablet_design/home_page.dart';
import 'package:tablet_design/core/utils/constant.dart';
import 'package:tablet_design/core/network/local_network.dart';
class LoginScreen extends StatefulWidget {
  static final ROUTE='LogIn';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool password = true;
  var selectLecture;
  var selectTopic;
  Icon ic = Icon(Icons.remove_red_eye_outlined);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  var email,pass ;
  bool isloading=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10.0,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Log in'.tr,
                      style: TextStyle(
                        fontSize: 40.0,
                        fontFamily: AppStrings.constantFont,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 80.0,
                  ),
                  Image.asset(
                    ImageAssets.logo,
                    width: 160,
                    height: 160,
                    alignment: Alignment.center,
                  ),
                  SizedBox(
                    height: 80.0,
                  ),
                  TextFormField(
                    onChanged: (data){
                      email=data;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email address must not be empty'.tr;
                      }
                      if (value!.isEmail) {

                      }else{
                        return 'Please Enter The Correct Email'.tr;
                      }
                      return null;
                    },
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Enter Your Email'.tr,
                      prefixIcon: Icon(
                        Icons.email,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color:AppColors.primary,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    onChanged: (data){
                      pass=data;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password must not be empty'.tr;
                      }

                      return null;
                    },
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: password,
                    decoration: InputDecoration(
                      labelText: 'Password'.tr,
                      prefixIcon: Icon(
                        Icons.lock,
                      ),
                      suffixIcon: IconButton(
                        icon: ic,
                        onPressed: () {
                          setState(() {
                            password = !password;
                            if (password == false)
                              ic = Icon(Icons.visibility);
                            else
                              ic = Icon(Icons.visibility_off);
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: AppColors.primary,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 50,
                    color: AppColors.primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        try {
                         await loginuser();
                          Navigator.pushReplacementNamed(context,HomePage.ROUTE);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            constants.SnacMessage(context, "user not found".tr);
                          } else if (e.code == 'wrong-password') {
                            constants.SnacMessage(context, "wrong password".tr);

                          }
                        }

                      }
                    },
                    child: Text(
                      'Log in'.tr,
                      style: TextStyle(
                          fontFamily: AppStrings.constantFont,
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
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

  Future<void> loginuser() async {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: pass
    );
     cashNetwork.insertToCash( key: "pass",value: pass!);
     cashNetwork.insertToCash( key: "email",value: email!);
     cashNetwork.insertToCash(key: "token", value: credential.user!.uid);
     print("the tt $token");
  }
}

