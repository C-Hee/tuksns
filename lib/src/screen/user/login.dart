import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sns_flutter/src/screen/user/register.dart';
import '../../repository/user_repository.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final userRepo = UserRepository();

  // void submitLogin() async {
  //   if (_formKey.currentState!.validate()) {
  //     String email = _emailController.text;
  //     String password = _passwordController.text;

  //     final prefs = await SharedPreferences.getInstance();
  //     String? token = await userRepo.login(email, password);
  //     if (token == null) {
  //       AlertDialog(
  //         shape:
  //             RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
  //         title: const Text('로그인 실패'),
  //         content: const Text('로그인 실패'),
  //       );
  //     } else {
  //       await prefs.setString('token', token);
  //     }
  //     Get.back();
  //   }
  // }
  void submitLogin() async {
    Get.back();
  }

  void submitRegister() async {
    Get.off(const Register());
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('로그인',
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold)),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          '반갑습니다 현장실습 프로젝트 교과 프로젝트 SNS 서비스입니다.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey),
                        ),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(labelText: '아이디(이메일)'),
                        ),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(labelText: '비밀번호'),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                onPressed: submitRegister, child: Text('회원가입')),
                            SizedBox(
                              width: 20,
                            ),
                            ElevatedButton(
                                onPressed: submitLogin, child: Text('로그인'))
                          ],
                        ),
                      ],
                    )))));
  }
}
