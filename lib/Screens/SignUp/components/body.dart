import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login_signup_page_flutter/Screens/Login/login_screen.dart';
import 'package:login_signup_page_flutter/Screens/Signup/components/background.dart';
import 'package:login_signup_page_flutter/Screens/Signup/components/or_divider.dart';
import 'package:login_signup_page_flutter/Screens/Signup/components/social_icon.dart';
import 'package:login_signup_page_flutter/components/already_have_an_account_acheck.dart';
import 'package:login_signup_page_flutter/components/rounded_button.dart';
import 'package:login_signup_page_flutter/components/rounded_input_field.dart';
import 'package:login_signup_page_flutter/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController taikhoan = TextEditingController();
    TextEditingController matkhau = TextEditingController();
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
            RoundedInputField(
              tk: taikhoan,
              hintText: "Your Email",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              mk: matkhau,
              onChanged: (value) {},
            ),
            RoundedButton(
              text: "SIGNUP",
              press: () => ketnoidulieu(taikhoan.text, matkhau.text),
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocalIcon(
                  iconSrc: "assets/icons/facebook.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/twitter.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/google-plus.svg",
                  press: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
  void ketnoidulieu(String tk, String mk)
  async{
    var url= "https://dhv-store.000webhostapp.com/dangky.php";
    var res = await http.post(url, body:{
      'tk':tk, 'mk':mk
    });
    var ktdulieu = json.decode(res.body);
    if(ktdulieu== "Da co tk"){
      Fluttertoast.showToast(
        msg: "Đã có tài khoản này\nVui lòng thử lại",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0
    );
  
    }
    else{
        Fluttertoast.showToast(
        msg: "Thành công",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}