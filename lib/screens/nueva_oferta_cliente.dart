// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_aplicacion_ganadora/providers/providers.dart';
import 'package:flutter_aplicacion_ganadora/services/services.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickalert/quickalert.dart';

class NuevaOfertaClienteScreen extends StatefulWidget {
  const NuevaOfertaClienteScreen({super.key});

  @override
  State<NuevaOfertaClienteScreen> createState() =>
      _NuevaOfertaClienteScreenState();
}

class _NuevaOfertaClienteScreenState extends State<NuevaOfertaClienteScreen> {
  String image = '';
  @override
  Widget build(BuildContext context) {
    final nuevaTareaFormProvider = Provider.of<NuevaTareaFormProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[800],
        title: const Text('Nueva Oferta'),
        leading: IconButton(
            onPressed: () => Navigator.pushReplacementNamed(context, 'cliente'),
            icon: Icon(Icons.arrow_back)),
      ),
      body: Stack(children: [
        Container(
          color: Colors.grey[300],
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.35,
                width: MediaQuery.of(context).size.width,
                color: Colors.blueGrey[700],
                child: Stack(children: [
                  Positioned(
                    top: 40,
                    left: MediaQuery.of(context).size.width / 5,
                    right: MediaQuery.of(context).size.width / 5,
                    child: SizedBox(
                      height: 150,
                      width: 250,
                      child: image == ''
                          ? Image.asset(
                              'assets/images/no-image.jpg',
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              File(image),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
        Positioned(
            bottom: 25,
            left: 15,
            right: 15,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.60,
              width: MediaQuery.of(context).size.width * 0.9,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Form(
                    key: nuevaTareaFormProvider.formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Text(
                            'Información',
                            style: TextStyle(
                                fontSize: 35, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          child: TextFormField(
                            autocorrect: false,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                enabledBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blueGrey),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blue, width: 2),
                                ),
                                hintText: 'Título',
                                labelText: 'Título',
                                labelStyle: const TextStyle(color: Colors.grey),
                                prefixIcon: const Icon(Icons.person) != null
                                    ? Icon(Icons.person,
                                        color: Colors.blueGrey[600])
                                    : null),
                            onChanged: (value) {
                              nuevaTareaFormProvider.title = value;
                            },
                            validator: (value) {
                              return (value != null && value.length >= 6)
                                  ? null
                                  : 'El título tiene que tener mas de 6 caracteres';
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.376,
                                  child: TextFormField(
                                    autocorrect: false,
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blueGrey),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blue, width: 2),
                                        ),
                                        hintText: '658443456',
                                        labelText: 'Teléfono de contacto',
                                        labelStyle:
                                            const TextStyle(color: Colors.grey),
                                        prefixIcon:
                                            const Icon(Icons.phone) != null
                                                ? Icon(Icons.phone,
                                                    color: Colors.blueGrey[600])
                                                : null),
                                    onChanged: (value) {
                                      nuevaTareaFormProvider.phone = value;
                                    },
                                    validator: (value) {
                                      return (value != null &&
                                              (value.length == 9 ||
                                                  value.length == 0))
                                          ? null
                                          : 'El teléfono es inválido';
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.50,
                                  child: TextFormField(
                                    autocorrect: false,
                                    keyboardType: TextInputType.streetAddress,
                                    decoration: InputDecoration(
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blueGrey),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blue, width: 2),
                                        ),
                                        hintText: 'Avd/ calle falsa 123',
                                        labelText: 'Dirección de usuario',
                                        labelStyle:
                                            const TextStyle(color: Colors.grey),
                                        prefixIcon:
                                            const Icon(Icons.house) != null
                                                ? Icon(Icons.house,
                                                    color: Colors.blueGrey[600])
                                                : null),
                                    onChanged: (value) {
                                      nuevaTareaFormProvider.adress = value;
                                    },
                                    validator: (value) {
                                      return (value != null &&
                                              (value.length >= 6 ||
                                                  value.length == 0))
                                          ? null
                                          : 'La dirección tiene que tener mas de 6 caracteres';
                                    },
                                  ),
                                ),
                              ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 8.0),
                          child: TextFormField(
                            autocorrect: false,
                            keyboardType: TextInputType.multiline,
                            maxLines: 4,
                            decoration: InputDecoration(
                                enabledBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blueGrey),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blue, width: 2),
                                ),
                                hintText: 'Descipción de problema',
                                labelText: 'Descripción del problema',
                                labelStyle: const TextStyle(color: Colors.grey),
                                prefixIcon: const Icon(Icons.error) != null
                                    ? Icon(Icons.error,
                                        color: Colors.blueGrey[600])
                                    : null),
                            onChanged: (value) {
                              nuevaTareaFormProvider.description = value;
                            },
                            validator: (value) {
                              return (value != null && value.length >= 6)
                                  ? null
                                  : 'La descripción tiene que tener mas de 6 caracteres';
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 25, horizontal: 8),
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            disabledColor: Colors.grey,
                            elevation: 0,
                            color: Colors.blueGrey[600],
                            onPressed: () async {
                              FocusScope.of(context).unfocus();
                              if (!nuevaTareaFormProvider.isValidForm()) return;
                              QuickAlert.show(
                                  context: context,
                                  barrierDismissible: false,
                                  type: QuickAlertType.loading,
                                  title: 'Procesando',
                                  confirmBtnColor: Colors.blueGrey,
                                  text: 'Subiendo imagen al servidor',
                                  confirmBtnText: 'Vale');
                              final userService = Provider.of<UserService>(
                                  context,
                                  listen: false);

                              await userService.crearNuevaTareaUsuario(
                                nuevaTareaFormProvider.title,
                                nuevaTareaFormProvider.description,
                                nuevaTareaFormProvider.adress,
                                nuevaTareaFormProvider.phone,
                              );
                              Navigator.pop(context);

                              // ignore: use_build_context_synchronously
                              Navigator.pushReplacementNamed(
                                  context, 'cliente');
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 80, vertical: 15),
                              child: const Text(
                                'Guardar',

                                //loginForm.isLoading ? 'Wait' : 'Submit',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            )),
        Positioned(
          top: 18,
          right: MediaQuery.of(context).size.width / 7,
          child: IconButton(
            icon: const Icon(Icons.camera_alt),
            onPressed: () async {
              final userService =
                  Provider.of<UserService>(context, listen: false);

              final ImagePicker _picker = ImagePicker();
              final XFile? photo =
                  await _picker.pickImage(source: ImageSource.camera);

              if (photo == null) {
                print("no se ha elegido imagen");
                return;
              }
              setState(() {
                image = photo.path;
              });
              userService.updateImage(photo.path);
            },
            color: Colors.white,
          ),
        ),
      ]),
    );
  }
}
