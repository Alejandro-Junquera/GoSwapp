import 'package:flutter/material.dart';
import 'package:flutter_aplicacion_ganadora/src/widgets/slideshow.dart';

class GuiaAdmin extends StatelessWidget {
  const GuiaAdmin({super.key});

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
                        child: Image.asset('assets/images/guia/admin_1.jpeg')),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        'En esta ventana se podrá ver una lista con todas las tareas que aún no tiene asignado un ciclo.',
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
                        child: Image.asset('assets/images/guia/admin_2.jpeg')),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        'Pulsando en el icono superior derecho se mostrará la descripción de la tarea para decidiar qué ciclo asignarle.',
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
                        child: Image.asset('assets/images/guia/admin_3.jpeg')),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        'Para elegir un ciclo se pulsa en "Seleccione un ciclo" y se selecciona una entre las opciones disponibles.',
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
                        child: Image.asset('assets/images/guia/admin_4.jpeg')),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        'Para publicar una tarea se pulsa el botón verde, en el caso de que la tarea no sea adecuada se podrá eliminar pulsando el botón rojo.',
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
                        child: Image.asset('assets/images/guia/admin_5.jpeg')),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        'En esta ventana se podrá ver una lista de todos los profesores.',
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
                        child: Image.asset('assets/images/guia/admin_6.jpeg')),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        'Se podrá editar un profesor (botón azul), eliminar (boton rojo) o crear un nuevo profesor (botón inferior derecho).',
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
                        child: Image.asset('assets/images/guia/admin_7.jpeg')),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        'Una vez pulsado el botón de crear profesor, se rellenarán los datos personales y se le asignará un ciclo. Para finalizar se pulsará el botón "Crear"',
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
