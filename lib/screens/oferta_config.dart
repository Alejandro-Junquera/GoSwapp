import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class OfertaConfigScreen extends StatefulWidget {
  const OfertaConfigScreen({super.key});

  @override
  State<OfertaConfigScreen> createState() => _OfertaConfigScreenState();
}

class _OfertaConfigScreenState extends State<OfertaConfigScreen> {
  whatsapp() async {
    var contact = "+34619809487";
    var androidUrl =
        "whatsapp://send?phone=$contact&text=Hola soy [Inserte nombre profesor], le contanctamos del Instituto San Ignacio Cadiz con motivo de su publicación [Inserte titulo de tarea] en nuestra aplicación GoSwapp. Nos gustaría fijar una fecha y hora a la que podamos ir a su domicilio a solucionar su problema";

    await launchUrl(Uri.parse(androidUrl));
  }

  final listaAlumnos = [
    _Alumno("ALBERTO", "IEA", false),
    _Alumno("ALEJANDRO", "IEA", false),
    _Alumno("JAVIER", "IEA", true),
  ];
  List<bool> isSelected = [false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Oferta"),
          actions: [
            IconButton(
                onPressed: () => whatsapp(), icon: Icon(Icons.phone_android))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: _CardPersonalizada(),
              ),
              ExpansionTile(
                initiallyExpanded: true,
                title: const Text("Lista de alumnos interesados"),
                children: [
                  SingleChildScrollView(
                    child: SizedBox(
                      height: 250,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: listaAlumnos.length,
                        itemBuilder: (context, index) {
                          final alumno = listaAlumnos[index];

                          Color selectedBorderColor = Colors.white;
                          Color fillColor = Colors.white;

                          if (!alumno.post) {
                            isSelected = [false, true];
                            selectedBorderColor = Colors.green[700] as Color;
                            fillColor = Colors.green[100] as Color;
                          } else {
                            isSelected = [true, false];
                            selectedBorderColor = Colors.red[700] as Color;
                            fillColor = Colors.red[100] as Color;
                          }

                          return ListTile(
                            title: Row(
                              children: [
                                Text(alumno.nombre),
                                const Spacer(),
                                ToggleButtons(
                                  selectedBorderColor: selectedBorderColor,
                                  fillColor: fillColor,
                                  direction: Axis.horizontal,
                                  isSelected: isSelected,
                                  onPressed: (int index) {
                                    setState(() {
                                      if (index == 0) {
                                        alumno.post = true;
                                      } else {
                                        alumno.post = false;
                                      }
                                    });
                                  },
                                  children: const [
                                    Icon(
                                      Icons.cancel,
                                      color: Colors.red,
                                    ),
                                    Icon(
                                      Icons.done,
                                      color: Colors.green,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            subtitle: Text(alumno.curso),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                    color: const Color.fromARGB(255, 217, 217, 217),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        height: 220,
                        width: MediaQuery.of(context).size.width,
                        child: Column(children: [
                          const Text(
                            'Comentario Cliente',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Text(
                                "Ha finalizado la tarea en muy poco tiempo y en unas condiciones muy aceptables para ser un alumno.",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                          RatingBarIndicator(
                            itemCount: 5,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => const Icon(
                                Icons.heart_broken,
                                color: Colors.red),
                            rating: 4.5, //TODO: NUMERO CAMBIABLE
                          ),
                        ]),
                      ),
                    )),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    onPressed: () {},
                    color: Colors.red,
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: const Text(
                          'Eliminar',
                          textAlign: TextAlign.center,
                        )),
                  ),
                  MaterialButton(
                    onPressed: () {},
                    color: Colors.grey,
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: const Text(
                          'Archivar',
                          textAlign: TextAlign.center,
                        )),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}

class _CardPersonalizada extends StatelessWidget {
  const _CardPersonalizada({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Card(
        color: const Color.fromARGB(255, 217, 217, 217),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/enchufeRoto.jpg',
                    fit: BoxFit.cover,
                    width: 150,
                    height: 150,
                    scale: 5,
                  ),
                  Column(
                    children: [
                      Text(
                        "Cambiar interruptor",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 100,
                        child: const SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Text(
                            "Modificar interruptor de corriente en mal estado debido a un golpe. Está roto",
                            maxLines: 50,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(children: [
                RatingBarIndicator(
                  itemCount: 5,

                  itemBuilder: (context, _) =>
                      const Icon(Icons.star, color: Colors.amber),
                  rating: 2.5, //TODO: NUMERO CAMBIABLE
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: IconButton(
                      color: Colors.blue,
                      onPressed: (() {
                        Navigator.pushNamed(context, 'googleMap');
                      }),
                      icon: Icon(Icons.location_on)),
                )
              ]),
            ],
          ),
        ),
      ),
    );
  }
}

//TODO:ELIMINAR EN UN FUTURO
class _Alumno {
  String nombre;
  String curso;
  bool post;
  _Alumno(this.nombre, this.curso, this.post);
}
