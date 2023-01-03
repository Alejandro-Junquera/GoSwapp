import 'package:flutter/material.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class OfertasGlobalesPage extends StatefulWidget {
  const OfertasGlobalesPage({super.key});

  @override
  State<OfertasGlobalesPage> createState() => _OfertasGlobalesPageState();
}

class _OfertasGlobalesPageState extends State<OfertasGlobalesPage> {
  final listaOfertas = [
    _Oferta('Cambio Enchufe', 'NECESITO CAMBIAR UN ENCHUFE', 'enchufe.jpg'),
    _Oferta('Pintar paredes', 'nueva mano de pintura', 'enchufe.jpg'),
    _Oferta('Cambio Enchufe', 'NECESITO CAMBIAR UN ENCHUFE', 'enchufe.jpg'),
    _Oferta('Pintar paredes', 'nueva mano de pintura', 'enchufe.jpg')
  ];

  late TransformationController controller;
  TapDownDetails? tapDownDetails;
  @override
  void initState() {
    super.initState();
    controller = TransformationController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          width: double.infinity,
          color: Colors.red,
          child: const Text(
            'Filtros en progreso',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: listaOfertas.length,
              itemBuilder: (context, index) {
                final oferta = listaOfertas[index];
                return ExpansionTile(
                  title: Text(oferta.titulo),
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
                              child: Image.asset(
                                'assets/images/${oferta.imagen}',
                                fit: BoxFit.cover,
                              ),
                            ),
                          )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(oferta.descripcion),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text("Seleccionar dificultad"),
                    const SizedBox(
                      height: 5,
                    ),
                    RatingBar.builder(
                      initialRating: 0.5,
                      minRating: 0.5,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) =>
                          const Icon(Icons.star, color: Colors.amber),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MaterialButton(
                          onPressed: () {},
                          color: Colors.green,
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.30,
                              child: const Text(
                                'Publicar',
                                textAlign: TextAlign.center,
                              )),
                        ),
                        MaterialButton(
                          onPressed: () {},
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
}

//TODO: BORRAR EN UN FUTURO
class _Oferta {
  final String titulo;
  final String descripcion;
  final String imagen;
  _Oferta(this.titulo, this.descripcion, this.imagen);
}
