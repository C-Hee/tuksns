import 'package:flutter/material.dart';
import '../../repository/user_repository.dart';

class Register extends StatefulWidget {
  const Register({super.key});
  @override
  State<Register> createState() => RegisterState();
}

class RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final userRepo = UserRepository();

  void submitButton() async {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      String email = _emailController.text;
      String password = _passwordController.text;
      await userRepo.register(name, email, password);
    }
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
                        const Text('회원가입',
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
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: '이름'),
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
                        ElevatedButton(
                            onPressed: submitButton, child: Text('가입하기')),
                      ],
                    )))));
  }
}
