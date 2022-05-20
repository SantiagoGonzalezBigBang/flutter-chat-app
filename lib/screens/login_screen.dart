import 'package:flutter/material.dart';

import 'package:chat/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
   
  const LoginScreen({
    Key? key
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(          
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Logo(
                  text: 'Login',
                ),
                _Form(),
                Labels(
                  route: 'register',
                  title: 'Crea una ahora!',
                  subtitle: '¿No tienes una cuenta?',
                ),
                Text(
                  'Terminos y condiciones de uso',
                  style: TextStyle(
                    fontWeight: FontWeight.w200
                  ),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}


class _Form extends StatefulWidget {
  const _Form({Key? key}) : super(key: key);

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {

  final emailEditingController    = TextEditingController();
  final passwordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 40.0,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 50.0
      ),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.mail_outline,
            hintText: 'Email',
            keyboardType: TextInputType.emailAddress,
            textEditingController: emailEditingController,
          ),
          CustomInput(
            icon: Icons.lock_outline,
            hintText: 'Password',
            obscureText: true,
            textEditingController: passwordEditingController,
          ),
          BlueButton(
            text: 'Login',
            onPressed: () {}
          )
        ],
      ),
    );
  }
}

