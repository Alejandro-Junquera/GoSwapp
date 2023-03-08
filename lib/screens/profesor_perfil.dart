import 'package:flutter/material.dart';

class ProfesorPerfilScreen extends StatefulWidget {
  const ProfesorPerfilScreen({super.key});

  @override
  State<ProfesorPerfilScreen> createState() => _ProfesorPerfilScreenState();
}

class _ProfesorPerfilScreenState extends State<ProfesorPerfilScreen> {
  List<_Alumno> alumnos = [
    _Alumno(
        nombre: "Alejandro",
        apellidos: 'Junquera Manrique',
        numBoscoins: 1500,
        numTareasCompletadas: 5),
    _Alumno(
        nombre: "Pepe",
        apellidos: 'Gonzalez Carrascosa',
        numBoscoins: 2000,
        numTareasCompletadas: 8),
    _Alumno(
        nombre: "Ana",
        apellidos: 'Quevedo Jazmin',
        numBoscoins: 500,
        numTareasCompletadas: 2),
    _Alumno(
        nombre: "Luis",
        apellidos: 'Quintero Velazquez',
        numBoscoins: 350,
        numTareasCompletadas: 1),
    _Alumno(
        nombre: "Rodrigo",
        apellidos: 'Valtonero Murillo',
        numBoscoins: 15000,
        numTareasCompletadas: 120),
    _Alumno(
        nombre: "Sara Maria",
        apellidos: 'Quesado Prado',
        numBoscoins: 1000,
        numTareasCompletadas: 4),
    _Alumno(
        nombre: "Alba",
        apellidos: 'Perez Perez',
        numBoscoins: 350,
        numTareasCompletadas: 7),
    _Alumno(
        nombre: "Ivan",
        apellidos: 'Rueda Quintero',
        numBoscoins: 1500,
        numTareasCompletadas: 5),
  ];
  double positiontop = 0;
  Icon icono = const Icon(Icons.keyboard_double_arrow_down);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Profile')),
      body: Stack(children: [
        //LISTADO DE ALUMNOS DEL CURSO DEL PROFESOR
        Positioned(
          top: MediaQuery.of(context).size.height * 0.2,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.70,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 115, left: 15),
                  child: Text(
                    'Lista de Alumnos',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                Divider(
                  color: Colors.grey,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.50,
                    child: ListView.builder(
                      itemCount: alumnos.length,
                      itemBuilder: (context, index) {
                        _Alumno alumno = alumnos[index];
                        return ListTile(
                            title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(alumno.nombre),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.task_rounded,
                                        color: Color.fromARGB(255, 68, 89, 99),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(alumno.numTareasCompletadas
                                          .toString()),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Image.asset(
                                        './assets/images/Boscoin.png',
                                        width: 30,
                                        height: 30,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(alumno.numBoscoins.toString())
                                    ],
                                  )
                                ]),
                            subtitle: Text(alumno.apellidos));
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        //CONTENEDOR CON LOS DATOS DEL PROFESOR
        Positioned(
          top: positiontop,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.40,
            child: CustomPaint(
              painter: _TeacherData(),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.40,
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, right: 10, left: 10),
                            child: TextField(
                              readOnly: true,
                              controller: TextEditingController()
                                ..text = 'Pablo Alfonso Gonzalez Diaz',
                              maxLines: 1,
                              decoration: const InputDecoration(
                                  disabledBorder: OutlineInputBorder(),
                                  enabled: false,
                                  label: Text('Nombre Completo',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Color.fromARGB(
                                              255, 68, 89, 99)))),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.50,
                                child: TextField(
                                    readOnly: true,
                                    controller: TextEditingController()
                                      ..text = '658213685',
                                    maxLines: 1,
                                    decoration: const InputDecoration(
                                        disabledBorder: OutlineInputBorder(),
                                        enabled: false,
                                        prefixIcon: Icon(
                                          Icons.phone,
                                          color:
                                              Color.fromARGB(255, 68, 89, 99),
                                        ))),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.40,
                                child: TextField(
                                  readOnly: true,
                                  controller: TextEditingController()
                                    ..text = 'Electricidad',
                                  maxLines: 1,
                                  decoration: const InputDecoration(
                                      disabledBorder: OutlineInputBorder(),
                                      enabled: false,
                                      label: Text('Curso',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: Color.fromARGB(
                                                  255, 68, 89, 99)))),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 5, right: 10, left: 10),
                            child: TextField(
                              readOnly: true,
                              controller: TextEditingController()
                                ..text = 'Pablo Alfonso Gonzalez Diaz',
                              maxLines: 1,
                              decoration: const InputDecoration(
                                  disabledBorder: OutlineInputBorder(),
                                  enabled: false,
                                  prefixIcon: Icon(
                                    Icons.home,
                                    color: Color.fromARGB(255, 68, 89, 99),
                                  )),
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        bottom: MediaQuery.of(context).size.width * 0.01,
                        right: MediaQuery.of(context).size.width * 0.07,
                        child: IconButton(
                          iconSize: 70,
                          color: Colors.white,
                          icon: icono,
                          onPressed: () {
                            if (positiontop == 0) {
                              setState(() {
                                positiontop =
                                    MediaQuery.of(context).size.height * 0.29;
                                icono = const Icon(
                                  Icons.keyboard_double_arrow_up,
                                );
                              });
                            } else {
                              setState(() {
                                positiontop = 0;
                                icono = const Icon(
                                    Icons.keyboard_double_arrow_down);
                              });
                            }
                          },
                        ),
                      )
                    ],
                  )),
            ),
          ),
        ),

        //IMAGEN USUARIO
        Positioned(
          top: 0,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blueGrey[200],
            ),
            height: MediaQuery.of(context).size.height * 0.29,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                const SizedBox(
                  height: 19,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      './assets/images/iconoProfesor.png',
                      width: 200,
                      height: 200,
                      alignment: Alignment.center,
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

class _TeacherData extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint();

    paint.color = Colors.blueGrey[200]!;
    //paint.color = Colors.blueGrey[200]!;
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 10;

    final path = Path();

    path.lineTo(0, size.height * 0.70);
    path.quadraticBezierTo(1, size.height * 0.80, 25, size.height * 0.80);
    path.lineTo(size.width * 0.65, size.height * 0.80);
    path.arcToPoint(Offset(size.width * 1.001, size.height * 0.80),
        radius: Radius.circular(1), clockwise: false);
    path.lineTo(size.width, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

//BORRAR MAS TARDE
class _Alumno {
  String nombre;
  String apellidos;
  int numBoscoins;
  int numTareasCompletadas;
  _Alumno(
      {required this.nombre,
      required this.apellidos,
      required this.numBoscoins,
      required this.numTareasCompletadas});
}
