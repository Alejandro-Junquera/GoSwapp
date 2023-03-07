// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_aplicacion_ganadora/services/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:provider/provider.dart';
import '../../models/models.dart';

class OfertasGlobalesPage extends StatefulWidget {
  const OfertasGlobalesPage({super.key});

  @override
  State<OfertasGlobalesPage> createState() => _OfertasGlobalesPageState();
}

class _OfertasGlobalesPageState extends State<OfertasGlobalesPage> {
  List<TareaDelCiclo> listaOfertasSinDificultad = [];
  obtenerTareasSinDificultad() async {
    final teacherService = Provider.of<TeacherService>(context, listen: false);
    await teacherService.obtenerTareasDeUnCiclo();
    setState(() {
      listaOfertasSinDificultad = teacherService.tareasProf;
    });
  }

  late TransformationController controller;
  TapDownDetails? tapDownDetails;
  @override
  void initState() {
    super.initState();
    obtenerTareasSinDificultad();
    controller = TransformationController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final teacherService = Provider.of<TeacherService>(context);
    if (teacherService.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: listaOfertasSinDificultad.length,
              itemBuilder: (context, index) {
                final tarea = listaOfertasSinDificultad[index];
                double dificultad = 0;

                return ExpansionTile(
                  title: Text(tarea.title.toString()),
                  children: [
                    GestureDetector(
                      onDoubleTapDown: (details) => tapDownDetails = details,
                      onDoubleTap: () {
                        final position = tapDownDetails!.localPosition;

                        const double scale = 3;
                        final x = -position.dx * (scale - 1);
                        final y = -position.dy * (scale - 1);
                        final zoomed = Matrix4.identity()
                          ..translate(x, y)
                          ..scale(scale);

                        final value = controller.value.isIdentity()
                            ? zoomed
                            : Matrix4.identity();
                        controller.value = value;
                      },
                      child: InteractiveViewer(
                          transformationController: controller,
                          panEnabled: true,
                          scaleEnabled: false,
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                'https://static.vecteezy.com/system/resources/previews/005/337/799/non_2x/icon-image-not-found-free-vector.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(tarea.description.toString()),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text("Seleccionar dificultad"),
                    const SizedBox(
                      height: 5,
                    ),
                    RatingBar.builder(
                      initialRating: dificultad,
                      minRating: 0,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) =>
                          const Icon(Icons.star, color: Colors.amber),
                      onRatingUpdate: (rating) {
                        dificultad = rating;
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MaterialButton(
                          onPressed: () async {
                            FocusScope.of(context).unfocus();
                            final teacherService = Provider.of<TeacherService>(
                                context,
                                listen: false);

                            if (dificultad == 0) {
                              customToast(
                                  'Asigne una dificultad a la tarea', context);
                              print('entra');
                            } else {
                              customToast(
                                  'Tarea publicada correctamente', context);
                              await teacherService.asignarDificultadTarea(
                                  dificultad, tarea.id!);

                              listaOfertasSinDificultad.removeAt(index);
                            }
                          },
                          color: Colors.green,
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.30,
                              child: const Text(
                                'Publicar',
                                textAlign: TextAlign.center,
                              )),
                        ),
                        MaterialButton(
                          onPressed: () {
                            showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      title: Text(
                                          '¿Eliminar tarea ${tarea.title}?'),
                                      content: const Text('¿Estas seguro?'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('No'),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            final teacherService =
                                                Provider.of<TeacherService>(
                                                    context,
                                                    listen: false);
                                            teacherService
                                                .eliminarUnaTarea(tarea.id!);
                                            setState(() {
                                              listaOfertasSinDificultad
                                                  .removeAt(index);
                                            });
                                            customToast(
                                                'Tarea ${tarea.title} eliminada correctamente',
                                                context);
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Si'),
                                        ),
                                      ],
                                    ));
                          },
                          color: Colors.red,
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.30,
                              child: const Text(
                                'Eliminar',
                                textAlign: TextAlign.center,
                              )),
                        ),
                      ],
                    )
                  ],
                );
              }),
        ),
      ],
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
