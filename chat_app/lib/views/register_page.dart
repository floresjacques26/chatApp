// ignore: unused_import
import 'package:chat_app/components/auth_button.dart';
import 'package:chat_app/components/confirm_button.dart';
import 'package:chat_app/components/custom_input.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/utils/show_message.dart';
import 'package:chat_app/views/login_page.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.app_registration,
              size: 120,
              color: Color.fromRGBO(76, 175, 80, 1),
            ),
            const Text(
              'Cadastro',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomInput(
              controller: nameController,
              labelText: 'Nome',
            ),
            CustomInput(
              controller: emailController,
              labelText: 'Email',
            ),
            CustomInput(
              controller: phoneController,
              labelText: 'Telefone',
            ),
            CustomInput(
              controller: passwordController,
              labelText: 'Senha',
              isObscure: true,
            ),
            CustomInput(
              controller: confirmController,
              labelText: 'Repita sua Senha',
              isObscure: true,
            ),
            ConfirmButton(
              onPressed: () async {
                // if (passwordController.text != confirmController.text) {
                //   showMessage(context, 'As senhas não coincidem');
                //   return;
                // }
                try {
                  await FirebaseAuthService().register(
                    nameController.text,
                    phoneController.text,
                    emailController.text,
                    passwordController.text,
                  );
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                } catch (e) {
                  showMessage(context, e);
                }
              },
              labelText: 'Cadastrar',
            ),
          ],
        ),
      ),
    );
  }
}
