import 'package:flutter/material.dart';
import 'package:flutter_aplicacion_ganadora/providers/providers.dart';
import 'package:flutter_aplicacion_ganadora/src/pages/pages.dart';
import 'package:animate_do/animate_do.dart';
import 'package:provider/provider.dart';

import '../ui/input_decorations.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Bounce(
              delay: const Duration(milliseconds: 100),
              child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width,
                  child: const HeaderLogin()),
            ),
            FadeInDown(
              delay: const Duration(milliseconds: 800),
              child: const Text(
                'Login',
                style: TextStyle(fontSize: 50),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(50, 100, 50, 50),
              child: Form(child: _LoginForm()),
            ),
            FadeInUpBig(
              delay: const Duration(milliseconds: 200),
              child: TextButton(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, 'registro'),
                style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(
                        Colors.indigo.withOpacity(0.1)),
                    shape: MaterialStateProperty.all(const StadiumBorder())),
                child: const Text(
                  'Crear nueva cuenta',
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    return Form(
      key: loginForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          FadeInRight(
            delay: const Duration(milliseconds: 800),
            child: TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecorations.authInputDecoration(
                  hinText: 'Pepi.to@gmail.com',
                  labelText: 'Email',
                  prefixIcon: Icons.alternate_email_sharp,
                ),
                onChanged: (value) => loginForm.email = value,
                validator: (value) {
                  String pattern =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regExp = RegExp(pattern);
                  return regExp.hasMatch(value ?? '')
                      ? null
                      : 'Email no valido';
                }),
          ),
          const SizedBox(height: 30),
          FadeInRight(
            delay: const Duration(milliseconds: 900),
            child: TextFormField(
                autocorrect: false,
                obscureText: true,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecorations.authInputDecoration(
                    hinText: '*******',
                    labelText: 'Contraseña',
                    prefixIcon: Icons.lock_clock_outlined),
                onChanged: (value) => loginForm.contrasenia = value,
                validator: (value) {
                  return (value != null && value.length >= 6)
                      ? null
                      : 'La contraseña tiene que tener mas de 6 caracteres';
                }),
          ),
          const SizedBox(height: 30),
          FadeInUp(
            delay: const Duration(milliseconds: 800),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.blueGrey[600],
              onPressed: () {
                if (loginForm.email == 'profesor@gmail.com') {
                  Navigator.of(context).pushReplacementNamed('initProf');
                } else if (loginForm.email == 'cliente@gmail.com') {
                  Navigator.of(context).pushReplacementNamed('cliente');
                }
              }, //loginForm.isLoading
              //     ? null
              //     : () async {
              //         FocusScope.of(context).unfocus();

              //       },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: const Text(
                  'Iniciar Sesion',
                  //loginForm.isLoading ? 'Wait' : 'Submit',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
