import 'package:flutter/material.dart';
import 'package:flutter_aplicacion_ganadora/providers/providers.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:quickalert/quickalert.dart';
import '../models/models.dart';
import '../services/services.dart';
import 'package:provider/provider.dart';

class InfoOfertaClienteScreen extends StatefulWidget {
  const InfoOfertaClienteScreen({super.key});

  @override
  State<InfoOfertaClienteScreen> createState() =>
      _InfoOfertaClienteScreenState();
}

class _InfoOfertaClienteScreenState extends State<InfoOfertaClienteScreen> {
  double aux = 0;
  @override
  Widget build(BuildContext context) {
    final tarea = ModalRoute.of(context)!.settings.arguments as TareasDataUser;
    final comentarioFormProvider = Provider.of<ComentarioFormProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.40,
                child: tarea.imagen != null
                    ? Image.network(
                        'https://goswapp.allsites.es/storage/app/public/' +
                            tarea.imagen.toString(),
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'assets/images/no-image.jpg',
                        fit: BoxFit.cover,
                      ),
              ),
              Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.6,
                child: Column(
                  children: [
                    Container(
                      height: 60,
                      decoration:
                          BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                          blurStyle: BlurStyle.outer,
                          color: Colors.black.withOpacity(0.1),
                          offset: Offset(0.0, 0.0), //(x,y)
                          blurRadius: 16.0,
                        )
                      ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Text(
                              tarea.title.toString(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 26, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(tarea.createdAt.toString())
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: const Text(
                                    'Descripcion',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  tarea.description.toString(),
                                  textAlign: TextAlign.justify,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  'Valoración del Alumno',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Form(
                                    key: comentarioFormProvider.formKey,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    child: Column(
                                      children: [
                                        RatingBar.builder(
                                          ignoreGestures:
                                              tarea.clientRating != null
                                                  ? true
                                                  : false,
                                          initialRating:
                                              tarea.clientRating != null
                                                  ? double.parse(
                                                      tarea.clientRating!)
                                                  : 0,
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: false,
                                          itemCount: 5,
                                          itemPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 4.0),
                                          itemBuilder: (context, _) =>
                                              const Icon(Icons.favorite,
                                                  color: Colors.red),
                                          onRatingUpdate: (rating) {
                                            aux = rating;
                                            comentarioFormProvider
                                                .client_rating = rating;
                                          },
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
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
                                                    color: Colors.blue,
                                                    width: 2),
                                              ),
                                              labelText: 'Comentario',
                                              labelStyle:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                            maxLines: 5,
                                            onChanged: (value) {
                                              comentarioFormProvider.comment =
                                                  value;
                                            },
                                            validator: (value) {
                                              return (value != null &&
                                                      value.length >= 11)
                                                  ? null
                                                  : 'El comentario tiene que tener mas de 10 letras';
                                            }),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        tarea.comment == null
                                            ? MaterialButton(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                disabledColor: Colors.grey,
                                                elevation: 0,
                                                color: Colors.blueGrey[600],
                                                onPressed: () {
                                                  if (tarea.completionDate !=
                                                      null) {
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                    if (!comentarioFormProvider
                                                        .isValidForm()) return;
                                                    if (aux == 0) {
                                                      QuickAlert.show(
                                                          context: context,
                                                          barrierDismissible:
                                                              false,
                                                          type: QuickAlertType
                                                              .warning,
                                                          title: 'Lo sentimos',
                                                          confirmBtnColor:
                                                              Colors.blueGrey,
                                                          text:
                                                              'Debe puntuar el trabajo del alumno',
                                                          confirmBtnText:
                                                              'Vale');
                                                    } else {
                                                      final userService =
                                                          Provider.of<
                                                                  UserService>(
                                                              context,
                                                              listen: false);
                                                      userService.valorarTarea(
                                                          tarea.id!,
                                                          comentarioFormProvider
                                                              .client_rating,
                                                          comentarioFormProvider
                                                              .comment);
                                                      setState(() {
                                                        tarea.comment =
                                                            comentarioFormProvider
                                                                .comment;
                                                        tarea.clientRating =
                                                            aux.toString();
                                                      });
                                                      QuickAlert.show(
                                                          context: context,
                                                          barrierDismissible:
                                                              false,
                                                          type: QuickAlertType
                                                              .success,
                                                          title: 'Completado',
                                                          confirmBtnColor:
                                                              Colors.blueGrey,
                                                          text:
                                                              'Comentario publicado correctamente',
                                                          confirmBtnText:
                                                              'Vale');
                                                    }
                                                  } else {
                                                    QuickAlert.show(
                                                        context: context,
                                                        barrierDismissible:
                                                            false,
                                                        type:
                                                            QuickAlertType.info,
                                                        title: 'Informacion',
                                                        confirmBtnColor:
                                                            Colors.blueGrey,
                                                        text:
                                                            'No puedes comentar la tarea hasta que finalice',
                                                        confirmBtnText: 'Vale');
                                                  }
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 80,
                                                      vertical: 15),
                                                  child: const Text(
                                                    'Comentar',
                                                    //loginForm.isLoading ? 'Wait' : 'Submit',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              )
                                            : SizedBox(),
                                        const SizedBox(
                                          height: 20,
                                        )
                                      ],
                                    )),
                              ],
                            ),
                          ),
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: FloatingActionButton(
          elevation: 10,
          backgroundColor: Colors.white,
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('cliente');
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }
}
