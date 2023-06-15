import 'package:flutter/material.dart';
import 'package:flutter_aplicacion_ganadora/models/models.dart';
import 'package:flutter_aplicacion_ganadora/services/services.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class EditarProfresorScreen extends StatefulWidget {
  final ProfesorData profesor;
  const EditarProfresorScreen({super.key, required this.profesor});

  @override
  State<EditarProfresorScreen> createState() => _CrearProfresorScreenState();
}

bool selected = false;
String cursoDefault = 'Seleccione un Curso';

class _CrearProfresorScreenState extends State<EditarProfresorScreen> {
  ProfesorData? originalPerfil;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  obtenerProfesor() {
    setState(() {
      print(widget.profesor.address);
      originalPerfil = widget.profesor;
      firstNameController.text = widget.profesor.firstname ?? '';
      lastNameController.text = widget.profesor.surname ?? '';
      emailController.text = widget.profesor.email ?? '';
      mobileController.text = widget.profesor.mobile ?? '';
      addressController.text = widget.profesor.address ?? '';
    });
  }

  actualizarPerfil() async {
    // Verificar si hubo cambios
    if (originalPerfil!.firstname != firstNameController.text ||
        originalPerfil!.surname != lastNameController.text ||
        originalPerfil!.email != emailController.text ||
        originalPerfil!.mobile != mobileController.text ||
        originalPerfil!.address != addressController.text) {
      final teacherService =
          Provider.of<TeacherService>(context, listen: false);
      final resp = await teacherService.actualizarProfesorAdmin(
          firstNameController.text,
          lastNameController.text,
          emailController.text,
          mobileController.text,
          addressController.text,
          widget.profesor.userId);
      return resp;
    }
    return -1;
  }

  @override
  void initState() {
    super.initState();
    obtenerProfesor();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 105, 124, 136),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () async {
            Navigator.pushReplacementNamed(context, 'admin');
          },
        ),
        title: const Text('Editar Profesor'),
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
                          child: Column(
                            children: [
                              TextField(
                                controller: firstNameController,
                                maxLines: 1,
                                decoration: _CustomInputDecoration(
                                    '', 'Nombre', Icons.supervised_user_circle),
                              ),
                              const SizedBox(height: 15),
                              TextField(
                                controller: lastNameController,
                                maxLines: 1,
                                decoration: _CustomInputDecoration(
                                    '',
                                    'Apellido',
                                    Icons.supervised_user_circle_outlined),
                              ),
                              const SizedBox(height: 15),
                              TextField(
                                controller: emailController,
                                maxLines: 1,
                                decoration: _CustomInputDecoration(
                                    '', 'Email', Icons.alternate_email_sharp),
                              ),
                              const SizedBox(height: 15),
                              TextField(
                                controller: addressController,
                                maxLines: 1,
                                decoration: _CustomInputDecoration(
                                    '', 'Direccion', Icons.location_city),
                              ),
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.50,
                                    child: TextField(
                                      controller: mobileController,
                                      maxLines: 1,
                                      decoration: _CustomInputDecoration(
                                          '', 'Telefono', Icons.phone_android),
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.40,
                                    child: TextField(
                                      readOnly: true,
                                      controller: TextEditingController()
                                        ..text = widget.profesor.cicleName!,
                                      maxLines: 1,
                                      decoration: const InputDecoration(
                                          disabledBorder: OutlineInputBorder(),
                                          enabled: false,
                                          label: Text('Curso',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: Colors.white))),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
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
                                  if (await actualizarPerfil() == 1) {
                                    QuickAlert.show(
                                        context: context,
                                        barrierDismissible: false,
                                        type: QuickAlertType.success,
                                        title: 'Completado',
                                        confirmBtnColor: Colors.blueGrey,
                                        text: 'Profesor editado correctamente',
                                        showCancelBtn: false);
                                  } else if (await actualizarPerfil() == 0) {
                                    QuickAlert.show(
                                        context: context,
                                        barrierDismissible: false,
                                        type: QuickAlertType.warning,
                                        title: 'Cuidado',
                                        confirmBtnColor: Colors.blueGrey,
                                        text: 'Email duplicado',
                                        showCancelBtn: false);
                                  } else {}
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 80, vertical: 15),
                                  child: const Text(
                                    'Editar',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
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
