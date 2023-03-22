import 'package:flutter/material.dart';
import 'package:flutter_aplicacion_ganadora/src/widgets/slideshow.dart';

class GuiaAlumnoScreen extends StatelessWidget {
  const GuiaAlumnoScreen({super.key});

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
                        height: MediaQuery.of(context).size.height * 0.63,
                        child: Image.asset('assets/images/guia/al1.jpeg')),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        'En esta ventana se nos mostrará una lista con todas las tareas del ciclo, el color muestra el estado de las tareas. Si está en gris la podremos solicitar',
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
                        child: Image.asset('assets/images/guia/al2.jpeg')),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        'Si la tarea ya se ha solicitado la ventana será naranja',
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
                        child: Image.asset('assets/images/guia/al3.jpeg')),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        'Si se nos asigna la tarea la ventana aparecerá verde y el profesor nos contactará´para realizar la tarea',
                        textAlign: TextAlign.justify,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.60,
                        child: Image.asset('assets/images/guia/al4.jpeg')),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        'Las tareas finalizadas aparecen en rojo, pudiendo pulsar en el icono inferior izquierdo para ver una valoración de nuestro trabajo si hemos realizado esa tarea',
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
                        child: Image.asset('assets/images/guia/al5.jpeg')),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        'Pulsando en el botón superior derecho accederemos a nuestro perfil con toda nuestra información y el número de boscoins que tenemos',
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
