import 'package:chat/helpers/helpers.dart';
import 'package:flutter/material.dart';

import 'package:chat/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../services/services.dart';

class RegisterScreen extends StatelessWidget {
   
  const RegisterScreen({
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
                  text: 'Sign Up',
                ),
                _Form(),
                Labels(
                  route: 'login',
                  title: 'Ingresa ahora!',
                  subtitle: '¿Ya tienes una cuenta?',
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

  final nameEditingController     = TextEditingController();
  final emailEditingController    = TextEditingController();
  final passwordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final socketService = Provider.of<SocketService>(context);
    final authService   = Provider.of<AuthService>(context);
    
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
            icon: Icons.perm_identity,
            hintText: 'Name',
            keyboardType: TextInputType.name,
            textEditingController: nameEditingController,
          ),
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
            text: 'Sign Up',
            onPressed: authService.isAuthenticating ? null : () async {

              FocusScope.of(context).unfocus();
              
              final registerOk = await authService.register(
                name: nameEditingController.text.trim(),
                email: emailEditingController.text.trim(), 
                password: passwordEditingController.text.trim()
              );

              if (registerOk == true) {
                socketService.connect();
                _navigatorToUsersPage(context: context);
              } else {
                showCustomDialog(
                  context: context,
                  title: 'Registro incorrecto',
                  subtitle: registerOk
                );
              }

            }
          )
        ],
      ),
    );
  }

  void _navigatorToUsersPage({required BuildContext context}) {
    Navigator.pushReplacementNamed(context, 'users');
  } 
}

