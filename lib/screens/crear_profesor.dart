import 'package:flutter/material.dart';
import 'package:flutter_aplicacion_ganadora/services/services.dart';

// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import '../models/ciclos.dart';
import '../providers/providers.dart';

class CrearProfresorScreen extends StatefulWidget {
  const CrearProfresorScreen({super.key});

  @override
  State<CrearProfresorScreen> createState() => _CrearProfresorScreenState();
}

bool selected = false;
String cursoDefault = 'Seleccione un Curso';

class _CrearProfresorScreenState extends State<CrearProfresorScreen> {
  List<CicloData> ciclos = [];
  int ciclo = 0;

  getCiclos() async {
    ciclos.clear();
    final ciclosService = Provider.of<CiclosService>(context, listen: false);
    await ciclosService.getCiclos();
    ciclos = ciclosService.ciclos;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
      Duration(milliseconds: 200),
      () {
        getCiclos();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final nuevoProfForm = Provider.of<NuevoProfProvider>(context);
    obtenerCicloId(int index) {
      CicloData ciclo = ciclos[index];
      nuevoProfForm.ciclos_id = ciclo.id!;
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 105, 124, 136),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () async {
            Navigator.pushReplacementNamed(context, 'admin');
          },
        ),
        title: const Text('Crear Profesor'),
        backgroundColor: Colors.blueGrey[800],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.89,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () => setState(() {
                            selected = false;
                          }),
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: 20),
                              child: Container(
                                  decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 158, 158, 158),
                                      borderRadius: BorderRadius.only(
                                        bottomRight: Radius.elliptical(70, 40),
                                        bottomLeft: Radius.elliptical(70, 40),
                                      )),
                                  height: 100,
                                  width: 100,
                                  child: Center(
                                    child: Image.asset(
                                        './assets/images/iconoProfesor.png',
                                        width: 80,
                                        height: 80),
                                  )),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Form(
                            key: nuevoProfForm.formKey,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            child: Column(
                              children: [
                                TextFormField(
                                    style: const TextStyle(color: Colors.white),
                                    autocorrect: false,
                                    keyboardType: TextInputType.name,
                                    decoration: _CustomInputDecoration('Pepito',
                                        'Nombre', Icons.supervised_user_circle),
                                    onChanged: (value) =>
                                        nuevoProfForm.nombre = value,
                                    validator: (value) {
                                      return (value != null &&
                                              value.length >= 3)
                                          ? null
                                          : 'El nombre tiene que ser mayor a 3 caracteres';
                                    }),
                                const SizedBox(height: 5),
                                TextFormField(
                                    style: const TextStyle(color: Colors.white),
                                    autocorrect: false,
                                    keyboardType: TextInputType.name,
                                    decoration: _CustomInputDecoration(
                                        'Perez Perez',
                                        'Apellidos',
                                        Icons.supervised_user_circle_outlined),
                                    onChanged: (value) =>
                                        nuevoProfForm.apellido = value,
                                    validator: (value) {
                                      return (value != null &&
                                              value.length >= 5)
                                          ? null
                                          : 'Los apellidos tienen que tener mas de 5 caracteres';
                                    }),
                                const SizedBox(height: 5),
                                TextFormField(
                                    style: const TextStyle(color: Colors.white),
                                    autocorrect: false,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: _CustomInputDecoration(
                                        'pepi.to@cadiz.salelianos.edu',
                                        'Email',
                                        Icons.alternate_email_sharp),
                                    onChanged: (value) =>
                                        nuevoProfForm.email = value,
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
                                    style: const TextStyle(color: Colors.white),
                                    autocorrect: false,
                                    keyboardType: TextInputType.phone,
                                    decoration: _CustomInputDecoration(
                                        '123456789',
                                        'Telefono',
                                        Icons.phone_android),
                                    onChanged: (value) =>
                                        nuevoProfForm.telefono = value,
                                    validator: (value) {
                                      return (value != null &&
                                              value.length == 9)
                                          ? null
                                          : 'El telefono tiene que tener 9 caracteres';
                                    }),
                                const SizedBox(height: 5),
                                TextFormField(
                                    style: const TextStyle(color: Colors.white),
                                    autocorrect: false,
                                    keyboardType: TextInputType.streetAddress,
                                    decoration: _CustomInputDecoration(
                                        'Avd Campo del Sur',
                                        'Direccion',
                                        Icons.location_city),
                                    onChanged: (value) =>
                                        nuevoProfForm.direccion = value,
                                    validator: (value) {
                                      return (value != null &&
                                              value.length >= 11)
                                          ? null
                                          : 'La direccion tiene que tener mas de 10 caracteres';
                                    }),
                                const SizedBox(height: 5),
                                TextFormField(
                                    style: const TextStyle(color: Colors.white),
                                    autocorrect: false,
                                    obscureText: true,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: _CustomInputDecoration(
                                        '**********',
                                        'Contraseña',
                                        Icons.lock_clock_outlined),
                                    onChanged: (value) =>
                                        nuevoProfForm.contrasenia = value,
                                    validator: (value) {
                                      return (value != null &&
                                              value.length >= 6)
                                          ? null
                                          : 'La contraseña tiene que tener mas de 6 caracteres';
                                    }),
                                const SizedBox(height: 5),
                                TextFormField(
                                    style: const TextStyle(color: Colors.white),
                                    autocorrect: false,
                                    obscureText: true,
                                    keyboardType: TextInputType.visiblePassword,
                                    decoration: _CustomInputDecoration(
                                        '********',
                                        'Confirmar Contraseña',
                                        Icons.lock),
                                    onChanged: (value) =>
                                        nuevoProfForm.c_contrasenia = value,
                                    validator: (value) {
                                      return (value != null &&
                                              value ==
                                                  nuevoProfForm.contrasenia)
                                          ? null
                                          : 'La contraseña no coincide';
                                    }),
                                const SizedBox(
                                  height: 10,
                                ),
                                ListTile(
                                  onTap: () => setState(() {
                                    FocusScope.of(context).unfocus();
                                    selected = true;
                                  }),
                                  trailing: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Color.fromRGBO(55, 71, 79, 1),
                                  ),
                                  shape: const RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 3,
                                          color: Color.fromRGBO(55, 71, 79, 1)),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20))),
                                  title: Text(
                                    cursoDefault,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  disabledColor: Colors.grey,
                                  elevation: 0,
                                  color: Colors.blueGrey[800],
                                  onPressed: () async {
                                    FocusScope.of(context).unfocus();
                                    final registerService =
                                        Provider.of<AuthService>(context,
                                            listen: false);
                                    if (!nuevoProfForm.isValidForm()) return;
                                    if (nuevoProfForm.ciclos_id != 0) {
                                      final String? mensaje =
                                          await registerService
                                              .registerProfesor(
                                                  nuevoProfForm.nombre,
                                                  nuevoProfForm.apellido,
                                                  nuevoProfForm.email,
                                                  nuevoProfForm.contrasenia,
                                                  nuevoProfForm.telefono,
                                                  nuevoProfForm.direccion,
                                                  'teacher',
                                                  nuevoProfForm.ciclos_id);
                                      if (mensaje != null) {
                                        QuickAlert.show(
                                            context: context,
                                            barrierDismissible: false,
                                            type: QuickAlertType.warning,
                                            title: 'Lo sentimos',
                                            confirmBtnColor: Colors.blueGrey,
                                            text:
                                                'El email utilizado esta duplicado',
                                            confirmBtnText: 'Vale');
                                      } else {
                                        QuickAlert.show(
                                            context: context,
                                            barrierDismissible: false,
                                            type: QuickAlertType.success,
                                            title: 'Completado',
                                            confirmBtnColor: Colors.blueGrey,
                                            text:
                                                'Profesor registrado correctamente',
                                            showCancelBtn: false);
                                        Future.delayed(
                                          Duration(milliseconds: 1300),
                                          () {
                                            Navigator.pop(context);
                                            Navigator.pushReplacementNamed(
                                                context, 'admin');
                                          },
                                        );
                                      }
                                    } else {
                                      QuickAlert.show(
                                          context: context,
                                          barrierDismissible: false,
                                          type: QuickAlertType.info,
                                          title: 'Informacion',
                                          confirmBtnColor: Colors.blueGrey,
                                          text: 'Debes elegir un ciclo',
                                          confirmBtnText: 'Vale');
                                    }
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
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 1000),
                  curve: selected ? Curves.fastOutSlowIn : Curves.fastOutSlowIn,
                  width: MediaQuery.of(context).size.width,
                  height: selected ? MediaQuery.of(context).size.height : 0,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () => setState(() {
                            selected = false;
                          }),
                          child: Container(
                              color: const Color.fromARGB(0, 0, 0, 0),
                              width: MediaQuery.of(context).size.width,
                              height:
                                  MediaQuery.of(context).size.height * 0.55),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.45,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                          ),
                          child: SingleChildScrollView(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.45,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.separated(
                                separatorBuilder: (context, index) =>
                                    const Divider(
                                  height: 1,
                                  color: Colors.black,
                                ),
                                itemCount: ciclos.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selected = false;
                                        cursoDefault =
                                            ciclos[index].name.toString();
                                        obtenerCicloId(index);
                                      });
                                    },
                                    child: Container(
                                      color: Colors.grey[50],
                                      height: 60,
                                      width: MediaQuery.of(context).size.width,
                                      child: DropdownMenuItem(
                                        enabled: true,
                                        value: ciclos[index].id,
                                        onTap: () {},
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Text(
                                            ciclos[index].name.toString(),
                                            style:
                                                const TextStyle(fontSize: 18),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  InputDecoration _CustomInputDecoration(
      String hint, String label, IconData icon) {
    return InputDecoration(
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 175, 2, 2)),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide:
              BorderSide(width: 3, color: Color.fromARGB(255, 175, 2, 2)),
        ),
        errorStyle: const TextStyle(color: Color.fromARGB(255, 175, 2, 2)),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
                width: 3, color: Color.fromARGB(255, 175, 175, 175))),
        hintText: hint,
        labelText: label,
        hintStyle: const TextStyle(
          color: Color.fromRGBO(167, 165, 165, 1),
        ),
        labelStyle:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        prefixIcon: Icon(
          icon,
          color: const Color.fromRGBO(55, 71, 79, 1),
        ));
  }
}
