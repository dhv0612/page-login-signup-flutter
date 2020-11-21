import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login_signup_page_flutter/Screens/Login/components/background.dart';
import 'package:login_signup_page_flutter/Screens/Signup/signup_screen.dart';
import 'package:login_signup_page_flutter/components/already_have_an_account_acheck.dart';
import 'package:login_signup_page_flutter/components/rounded_button.dart';
import 'package:login_signup_page_flutter/components/rounded_input_field.dart';
import 'package:login_signup_page_flutter/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

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
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
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
              text: "LOGIN",
              press: () => ketnoidulieu(taikhoan.text, matkhau.text),
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void ketnoidulieu(String tk, String mk) async {
    var url = "https://dhv-store.000webhostapp.com/dangnhap.php";
    var res = await http.post(url, body: {'tk': tk, 'mk': mk});
    var ktdulieu = json.decode(res.body);
    if (ktdulieu == "Tai khoan hoac mat khau khong dung") {
      Fluttertoast.showToast(
          msg: "Tài khoản hoặc mật khẩu không đúng\nVui lòng thử lại",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
        msg: "Đăng nhập thành công",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}
