// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter_aplicacion_ganadora/services/auth_service.dart';
import 'package:flutter_aplicacion_ganadora/services/services.dart';
import 'package:flutter_aplicacion_ganadora/src/pages/pages.dart';
// ignore: depend_on_referenced_packages
import 'package:animate_do/animate_do.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import '../models/models.dart';
import '../providers/providers.dart';
import 'package:provider/provider.dart';
import '../ui/input_decorations.dart';

class RegistroScreen extends StatefulWidget {
  const RegistroScreen({super.key});

  @override
  State<RegistroScreen> createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Bounce(
              delay: const Duration(milliseconds: 100),
              child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width,
                  child: const HeaderLogin()),
            ),
            FadeInDown(
              delay: const Duration(milliseconds: 800),
              child: const Text(
                'Registro',
                style: TextStyle(fontSize: 50),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(50, 60, 50, 30),
              child: Form(child: _RegisterForm()),
            ),
            FadeInUpBig(
              delay: const Duration(milliseconds: 200),
              child: TextButton(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, 'login'),
                style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(
                        Colors.indigo.withOpacity(0.1)),
                    shape: MaterialStateProperty.all(const StadiumBorder())),
                child: const Text(
                  'Iniciar sesion',
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

class _RegisterForm extends StatefulWidget {
  const _RegisterForm({super.key});

  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {
  List<CiclosData> ciclos = [];

  getCiclos() async {
    ciclos.clear();
    final ciclosService = Provider.of<CiclosService>(context);
    await ciclosService.getCiclos();

    ciclos = ciclosService.ciclos;
  }

  bool valorSwitch = false;
  String tipo = '';
  @override
  Widget build(BuildContext context) {
    final registerForm = Provider.of<RegisterFormProvider>(context);
    getCiclos();
    return Form(
      key: registerForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          JelloIn(
            duration: const Duration(milliseconds: 800),
            delay: const Duration(milliseconds: 750),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text('¿Eres alumno?'),
                Switch(
                  // thumb color (round icon)
                  activeColor: Colors.blueGrey,
                  activeTrackColor: Colors.green[300],
                  inactiveThumbColor: Colors.blueGrey,
                  inactiveTrackColor: Colors.red[300],
                  splashRadius: 50.0,
                  // boolean variable value
                  value: valorSwitch,
                  // changes the state of the switch
                  onChanged: (value) => setState(() => valorSwitch = value),
                ),
              ],
            ),
          ),
          FadeInLeft(
            delay: const Duration(milliseconds: 800),
            child: TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.name,
                decoration: InputDecorations.authInputDecoration(
                    hinText: 'Pepito',
                    labelText: 'Nombre',
                    prefixIcon: Icons.supervised_user_circle),
                onChanged: (value) => registerForm.nombre = value,
                validator: (value) {
                  return (value != null && value.length >= 3)
                      ? null
                      : 'El nombre tiene que ser mayor a 3 caracteres';
                }),
          ),
          const SizedBox(height: 10),
          FadeInRight(
            delay: const Duration(milliseconds: 800),
            child: TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.name,
                decoration: InputDecorations.authInputDecoration(
                    hinText: 'Perez Perez',
                    labelText: 'Apellidos',
                    prefixIcon: Icons.supervised_user_circle_outlined),
                onChanged: (value) => registerForm.apellido = value,
                validator: (value) {
                  return (value != null && value.length >= 5)
                      ? null
                      : 'Los apellidos tienen que tener mas de 5 caracteres';
                }),
          ),
          const SizedBox(height: 10),
          FadeInLeft(
            delay: const Duration(milliseconds: 800),
            child: TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecorations.authInputDecoration(
                  hinText: 'Pepi.to@gmail.com',
                  labelText: 'Email',
                  prefixIcon: Icons.alternate_email_sharp,
                ),
                onChanged: (value) => registerForm.email = value,
                validator: (value) {
                  String pattern =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regExp = RegExp(pattern);
                  return regExp.hasMatch(value ?? '')
                      ? null
                      : 'Email no valido';
                }),
          ),
          const SizedBox(height: 10),
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
                onChanged: (value) => registerForm.contrasenia = value,
                validator: (value) {
                  return (value != null && value.length >= 6)
                      ? null
                      : 'La contraseña tiene que tener mas de 6 caracteres';
                }),
          ),
          const SizedBox(height: 10),
          FadeInLeft(
            delay: const Duration(milliseconds: 800),
            child: TextFormField(
                autocorrect: false,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecorations.authInputDecoration(
                    hinText: '*******',
                    labelText: 'Confirmar contraseña',
                    prefixIcon: Icons.lock),
                onChanged: (value) => registerForm.c_contrasenia = value,
                validator: (value) {
                  return (value != null && value == registerForm.contrasenia)
                      ? null
                      : 'La contraseña no coincide';
                }),
          ),
          const SizedBox(height: 30),
          FadeIn(
            delay: const Duration(milliseconds: 800),
            child: Visibility(
              visible: valorSwitch,
              child: DropdownButtonFormField(
                hint: const Text('Select a cicle'),
                items: ciclos.map((e) {
                  return DropdownMenuItem(
                    value: e.id,
                    child: Text(e.name.toString()),
                  );
                }).toList(),
                onChanged: (value) {
                  registerForm.ciclos_id = value!;
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          FadeInUp(
            delay: const Duration(milliseconds: 800),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.blueGrey[600],
              onPressed: registerForm.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();
                      final registerService =
                          Provider.of<AuthService>(context, listen: false);
                      if (!registerForm.isValidForm()) return;
                      final String? mensaje = await registerService.register(
                          registerForm.nombre,
                          registerForm.apellido,
                          registerForm.email,
                          registerForm.contrasenia,
                          valorSwitch == false ? 'C' : 'A',
                          registerForm.ciclos_id);
                      if (mensaje != null) {
                        // ignore: use_build_context_synchronously
                        customToast(mensaje, context);
                      } else {
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacementNamed(context, 'login');
                      }
                    },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: const Text(
                  'Registrarse',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void customToast(String message, BuildContext context) {
    showToast(
      message,
      textStyle: const TextStyle(
        fontSize: 14,
        wordSpacing: 0.1,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      textPadding: const EdgeInsets.all(23),
      fullWidth: true,
      toastHorizontalMargin: 25,
      borderRadius: BorderRadius.circular(15),
      backgroundColor: Colors.blueGrey[500],
      alignment: Alignment.bottomCenter,
      position: StyledToastPosition.top,
      duration: const Duration(seconds: 3),
      animation: StyledToastAnimation.slideFromTop,
      context: context,
    );
  }
}
