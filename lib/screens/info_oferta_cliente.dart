import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../models/models.dart';
import '../services/services.dart';

class InfoOfertaClienteScreen extends StatefulWidget {
  const InfoOfertaClienteScreen({super.key});

  @override
  State<InfoOfertaClienteScreen> createState() =>
      _InfoOfertaClienteScreenState();
}

class _InfoOfertaClienteScreenState extends State<InfoOfertaClienteScreen> {
  @override
  Widget build(BuildContext context) {
    final tarea = ModalRoute.of(context)!.settings.arguments as TareasDataUser;
    return Scaffold(
      appBar: AppBar(title: const Text('Información')),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                child: Stack(children: [
                  Positioned(
                    right: 0,
                    top: 100,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.24,
                      color: const Color.fromARGB(169, 212, 212, 212),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 5),
                        child: Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.35,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    tarea.title.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                    maxLines: 5,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 0,
                    child: Hero(
                        tag: 1,
                        child: Container(
                          decoration: const BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 25,
                            )
                          ]),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              tarea.imagen == ''
                                  ? 'https://static.vecteezy.com/system/resources/previews/005/337/799/non_2x/icon-image-not-found-free-vector.jpg'
                                  : 'https://static.vecteezy.com/system/resources/previews/005/337/799/non_2x/icon-image-not-found-free-vector.jpg',
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: 250,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )),
                  ),
                ]),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.1),
                child: Container(
                    color: const Color.fromARGB(169, 212, 212, 212),
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.62,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          const Text(
                            'Descripción',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                              height: 80,
                              child: Text(tarea.description.toString())),
                          const SizedBox(
                            height: 30,
                          ),
                          Visibility(
                            visible: true,
                            child: SizedBox(
                              child: Column(
                                children: [
                                  const Text('Valoración del Alumno',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  RatingBar.builder(
                                    ignoreGestures: tarea.clientRating != '0.00'
                                        ? true
                                        : false,
                                    initialRating: tarea.clientRating != null
                                        ? double.parse(tarea.clientRating!)
                                        : 0.5,
                                    minRating: 0.5,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemPadding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    itemBuilder: (context, _) => const Icon(
                                        Icons.favorite,
                                        color: Colors.red),
                                    onRatingUpdate: (rating) {},
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Form(
                                      child: Column(
                                    children: [
                                      TextFormField(
                                        initialValue: tarea.comment != null
                                            ? tarea.comment
                                            : '',
                                        readOnly: tarea.comment != null
                                            ? true
                                            : false,
                                        decoration: const InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blueGrey),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blue, width: 2),
                                          ),
                                          labelText: 'Comentario',
                                          labelStyle:
                                              TextStyle(color: Colors.grey),
                                        ),
                                        maxLines: 5,
                                      ),
                                      const SizedBox(
                                        height: 50,
                                      ),
                                      Visibility(
                                        visible: tarea.comment != null
                                            ? false
                                            : true,
                                        child: MaterialButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          disabledColor: Colors.grey,
                                          elevation: 0,
                                          color: Colors.blueGrey[600],
                                          onPressed: () {},
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 80, vertical: 15),
                                            child: const Text(
                                              'Comentar',
                                              //loginForm.isLoading ? 'Wait' : 'Submit',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ))
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
