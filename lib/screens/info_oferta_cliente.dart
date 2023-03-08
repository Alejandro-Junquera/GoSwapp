import 'package:flutter/material.dart';
import 'package:flutter_aplicacion_ganadora/providers/providers.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:animate_do/animate_do.dart';
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
  bool launchAnimation = false;
  @override
  Widget build(BuildContext context) {
    final tarea = ModalRoute.of(context)!.settings.arguments as TareasDataUser;
    final comentarioFormProvider = Provider.of<ComentarioFormProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[800],
        title: const Text('Información'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('cliente');
          },
        ),
      ),
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
                                  tarea.completionDate != null
                                      ? Text('Valoración del Alumno',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold))
                                      : FadeIn(
                                          child: Text(
                                              'Se podrá realizar una valoración de la tarea cuando esta finalice',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  FadeOut(
                                    animate: launchAnimation,
                                    child: Visibility(
                                      visible: tarea.completionDate != null
                                          ? true
                                          : false,
                                      child: Form(
                                          key: comentarioFormProvider.formKey,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
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
                                                  initialValue:
                                                      tarea.comment != null
                                                          ? tarea.comment
                                                          : '',
                                                  readOnly:
                                                      tarea.comment != null
                                                          ? true
                                                          : false,
                                                  decoration:
                                                      const InputDecoration(
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              Colors.blueGrey),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.blue,
                                                          width: 2),
                                                    ),
                                                    labelText: 'Comentario',
                                                    labelStyle: TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                  maxLines: 5,
                                                  onChanged: (value) {
                                                    comentarioFormProvider
                                                        .comment = value;
                                                  },
                                                  validator: (value) {
                                                    return (value != null &&
                                                            value.length >= 11)
                                                        ? null
                                                        : 'El comentario tiene que tener mas de 10 letras';
                                                  }),
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
                                                          BorderRadius.circular(
                                                              10)),
                                                  disabledColor: Colors.grey,
                                                  elevation: 0,
                                                  color: Colors.blueGrey[600],
                                                  onPressed: () {
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                    if (!comentarioFormProvider
                                                        .isValidForm()) return;
                                                    if (aux == 0) {
                                                      customToast(
                                                          'Puntue el trabajo del cliente',
                                                          context);
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
                                                      customToast(
                                                          'Valoracion publicada correctamente',
                                                          context);
                                                      setState(() {
                                                        launchAnimation =
                                                            !launchAnimation;
                                                      });
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
                                                ),
                                              ),
                                            ],
                                          )),
                                    ),
                                  )
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
