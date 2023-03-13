import 'package:flutter/material.dart';
import 'package:flutter_aplicacion_ganadora/src/widgets/slideshow.dart';

class GuiaProfesorScreen extends StatelessWidget {
  const GuiaProfesorScreen({super.key});

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
                        child: Image.asset('assets/images/guia/prof_8.jpeg')),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        'En la ventana aparecerá una lista de las tareas pertenecientes al ciclo del profesor que aún no tienen asignada una dificultad.',
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
                        child: Image.asset('assets/images/guia/prof_7.jpeg')),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        'Si pulsas una de las opciones de la lista se abrirá un desplegable con la información de la tarea.',
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
                        child: Image.asset('assets/images/guia/prof_6.jpeg')),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        'Una vez elegida una dificultad apropiada, pulsando el botón verde se publicará la tarea, en caso de querer eliminarla por no ser apta, se pulsará el botón rojo.',
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
                        child: Image.asset('assets/images/guia/prof_5.jpeg')),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        'En esta ventana aparece una lista de las tareas ya publicadas pudiendo filtrarlas entre las finalizadas y las que están en proceso',
                        textAlign: TextAlign.justify,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.585,
                        child: Image.asset('assets/images/guia/prof_4.jpeg')),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        'Podremos enviar un mensaje automático al cliente que ha solicitado la tarea  pulsando en el icono superior derecho, si pulsamos el icono de ubicación se nos abrirá un mapa interactivo que nos mostrará cómo llegar a la ubicación del usuario,',
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
                        child: Image.asset('assets/images/guia/prof_3.jpeg')),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        'Para asignar una tarea a un alumno sólo habrá que pulsar el botón verde, y para desasignarselo se pulsará el botón rojo.',
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
                        child: Image.asset('assets/images/guia/prof_2.jpeg')),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        'Una vez finalizada la tarea nos aparecerá la valoración del cliente.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: Image.asset('assets/images/guia/prof_1.jpeg')),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        'En el perfil se podrá ver a parte de los datos personales una lista de todos los alumnos del ciclo al que pertenece junto con el número de tareas que ha finalizado y el número de boscoins que tenen.',
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
