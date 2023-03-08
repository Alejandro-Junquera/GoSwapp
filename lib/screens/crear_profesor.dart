import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import '../ui/input_decorations.dart';

class CrearProfresorScreen extends StatelessWidget {
  const CrearProfresorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nuevoProfForm = Provider.of<NuevoProfProvider>(context);
    return Scaffold(
      backgroundColor: Colors.blueGrey[700],
      appBar: AppBar(
        title: const Text('Crear Profesor'),
        backgroundColor: Colors.blueGrey[800],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blueGrey[300],
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.elliptical(70, 40),
                        bottomLeft: Radius.elliptical(70, 40),
                      )),
                  height: 80,
                  width: 80,
                  child: const Icon(
                    Icons.school,
                    size: 40,
                  ),
                ),
              ),
            ),
            Form(
              key: nuevoProfForm.formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  TextFormField(
                      autocorrect: false,
                      keyboardType: TextInputType.name,
                      decoration: InputDecorations.authInputDecoration(
                          hinText: 'Pepito',
                          labelText: 'Nombre',
                          prefixIcon: Icons.supervised_user_circle),
                      onChanged: (value) => nuevoProfForm.nombre = value,
                      validator: (value) {
                        return (value != null && value.length >= 3)
                            ? null
                            : 'El nombre tiene que ser mayor a 3 caracteres';
                      }),
                  const SizedBox(height: 5),
                  TextFormField(
                      autocorrect: false,
                      keyboardType: TextInputType.name,
                      decoration: InputDecorations.authInputDecoration(
                          hinText: 'Perez Perez',
                          labelText: 'Apellidos',
                          prefixIcon: Icons.supervised_user_circle_outlined),
                      onChanged: (value) => nuevoProfForm.apellido = value,
                      validator: (value) {
                        return (value != null && value.length >= 5)
                            ? null
                            : 'Los apellidos tienen que tener mas de 5 caracteres';
                      }),
                  const SizedBox(height: 5),
                  TextFormField(
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecorations.authInputDecoration(
                        hinText: 'Pepi.to@gmail.com',
                        labelText: 'Email',
                        prefixIcon: Icons.alternate_email_sharp,
                      ),
                      onChanged: (value) => nuevoProfForm.email = value,
                      validator: (value) {
                        String pattern =
                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                        RegExp regExp = RegExp(pattern);
                        return regExp.hasMatch(value ?? '')
                            ? null
                            : 'Email no valido';
                      }),
                  const SizedBox(height: 5),
                  TextFormField(
                      autocorrect: false,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecorations.authInputDecoration(
                          hinText: '123456789',
                          labelText: 'Telefono',
                          prefixIcon: Icons.phone_android),
                      onChanged: (value) => nuevoProfForm.telefono = value,
                      validator: (value) {
                        return (value != null && value.length == 9)
                            ? null
                            : 'El telefono tiene que tener 9 caracteres';
                      }),
                  const SizedBox(height: 5),
                  TextFormField(
                      autocorrect: false,
                      obscureText: true,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecorations.authInputDecoration(
                          hinText: '*******',
                          labelText: 'Contraseña',
                          prefixIcon: Icons.lock_clock_outlined),
                      onChanged: (value) => nuevoProfForm.contrasenia = value,
                      validator: (value) {
                        return (value != null && value.length >= 6)
                            ? null
                            : 'La contraseña tiene que tener mas de 6 caracteres';
                      }),
                  const SizedBox(height: 5),
                  TextFormField(
                      autocorrect: false,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecorations.authInputDecoration(
                          hinText: '*******',
                          labelText: 'Confirmar contraseña',
                          prefixIcon: Icons.lock),
                      onChanged: (value) => nuevoProfForm.c_contrasenia = value,
                      validator: (value) {
                        return (value != null &&
                                value == nuevoProfForm.contrasenia)
                            ? null
                            : 'La contraseña no coincide';
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    disabledColor: Colors.grey,
                    elevation: 0,
                    color: Colors.blueGrey[600],
                    onPressed: nuevoProfForm.isLoading
                        ? null
                        : () async {
                            FocusScope.of(context).unfocus();
                            if (!nuevoProfForm.isValidForm()) return;
                          },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 80, vertical: 15),
                      child: const Text(
                        'Registrarse',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
