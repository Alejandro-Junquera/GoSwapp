import 'package:flutter/material.dart';
import 'package:flutter_aplicacion_ganadora/src/widgets/slideshow.dart';

class GuiaUserScreen extends StatelessWidget {
  const GuiaUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[500],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[800],
        title: Center(
          child: Text('Guia de Usuario'),
        ),
      ),
      body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SlideShow(
              bulletPrimario: 15,
              bulletSecundario: 8,
              colorunFocus: Colors.white,
              slides: [
                Column(
                  children: [
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.65,
                        child: Image.asset('assets/images/guia/user_1.jpeg')),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        'En esta ventana se muestra una lista con todas las tareas del usuario ',
                        textAlign: TextAlign.justify,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.65,
                        child: Image.asset('assets/images/guia/user_2.jpeg')),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        'El color de borde de las tarjetas indican los diferentes estados en los que puede encontrarse una tarea.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.65,
                        child: Image.asset('assets/images/guia/user_3.jpeg')),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        'Pulsando sobre la imagen podremos ver toda la informacion referente a la tarea',
                        textAlign: TextAlign.justify,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.63,
                        child: Image.asset('assets/images/guia/user_4.jpeg')),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        'Una vez finalizada la tarea, el usuario podrá valorar el trabajo de los alumnos',
                        textAlign: TextAlign.justify,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.65,
                        child: Image.asset('assets/images/guia/user_5.jpeg')),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        'El usuario podrá crear tareas, los campos imagen, dirección y telefono son opcionales.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.65,
                        child: Image.asset('assets/images/guia/user_6.jpeg')),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        'Pulsando el boton superior derecho podremos acceder a nuestro perfil con todos nuestros datos',
                        textAlign: TextAlign.justify,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    )
                  ],
                ),
              ])),
    );
  }
}
