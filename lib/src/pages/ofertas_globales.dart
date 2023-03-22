// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_aplicacion_ganadora/services/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
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

  Future refresh() async {
    obtenerTareasSinDificultad();
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
    return RefreshIndicator(
      onRefresh: refresh,
      child: Column(
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
                                child: tarea.imagen != null
                                    ? Image.network(
                                        'https://goswapp.allsites.es/storage/app/public/' +
                                            tarea.imagen.toString(),
                                        loadingBuilder: (BuildContext context,
                                            Widget child,
                                            ImageChunkEvent? loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }
                                          return Center(
                                            child: CircularProgressIndicator(
                                              value: loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes!
                                                  : null,
                                            ),
                                          );
                                        },
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset(
                                        'assets/images/no-image.jpg',
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        height: 250,
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
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 4.0),
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
                              final teacherService =
                                  Provider.of<TeacherService>(context,
                                      listen: false);

                              if (dificultad == 0) {
                                QuickAlert.show(
                                    context: context,
                                    barrierDismissible: false,
                                    type: QuickAlertType.info,
                                    title: 'Informacion',
                                    confirmBtnColor: Colors.blueGrey,
                                    text: 'Asigne una dificultad a la tarea',
                                    confirmBtnText: 'Vale');
                              } else {
                                QuickAlert.show(
                                    context: context,
                                    barrierDismissible: false,
                                    type: QuickAlertType.success,
                                    title: 'Completado',
                                    confirmBtnColor: Colors.blueGrey,
                                    text: tarea.title.toString() +
                                        ' solicitada correctamente',
                                    confirmBtnText: 'Vale');
                                await teacherService.asignarDificultadTarea(
                                    dificultad, tarea.taskId!);

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
                                  builder: (BuildContext context) =>
                                      AlertDialog(
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
                                              Navigator.pop(context);
                                              teacherService.eliminarUnaTarea(
                                                  tarea.taskId!);
                                              setState(() {
                                                listaOfertasSinDificultad
                                                    .removeAt(index);
                                              });
                                              QuickAlert.show(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  type: QuickAlertType.success,
                                                  title: 'Completado',
                                                  confirmBtnColor:
                                                      Colors.blueGrey,
                                                  text: tarea.title.toString() +
                                                      ' eliminada correctamente',
                                                  confirmBtnText: 'Vale');
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
      ),
    );
  }
}
