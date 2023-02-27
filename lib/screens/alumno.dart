import 'package:drop_cap_text/drop_cap_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AlumnoScreen extends StatefulWidget {
  const AlumnoScreen({super.key});

  @override
  State<AlumnoScreen> createState() => _AlumnoScreenState();
}

class _AlumnoScreenState extends State<AlumnoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
              child: Text(
            'Ofertas Alumno',
          )),
          actions: [
            Center(child: Text("1000")),
            SizedBox(
              width: 5,
            ),
            Image.asset(
              "assets/images/Boscoin.png",
              width: 30,
              height: 30,
            ),
            SizedBox(
              width: 5,
            ),
          ]),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.08,
          ),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: ((context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              bottomLeft: Radius.circular(30))),
                      child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.orangeAccent, width: 3),
                            color: Colors.grey[350],
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(30),
                                bottomLeft: Radius.circular(30)),
                          ),
                          width: MediaQuery.of(context).size.width * 0.94,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 30, bottom: 30),
                                child: Text(
                                  'Cablear red',
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: DropCapText(
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                  "Cablear una habitación con cable de red desde la habitación donde se encuentra el router",
                                  dropCap: DropCap(
                                      width: 150,
                                      height: 150,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(30),
                                              bottomLeft: Radius.circular(30)),
                                          child: Image.asset(
                                            "assets/images/cablear.jpg",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )),
                                ),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: const [
                                  Text(
                                    "Dificultad",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 50),
                                    child: Text(
                                      "BosCoins",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RatingBarIndicator(
                                    itemCount: 5,
                                    itemPadding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Colors.yellow),
                                    rating: 4, //TODO: NUMERO
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 80),
                                    child: Text(
                                      "400",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                disabledColor: Colors.grey,
                                elevation: 0,
                                color: Colors.blueGrey[600],
                                onPressed: null,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 80, vertical: 15),
                                  child: const Text(
                                    'Aplicada',
                                    //loginForm.isLoading ? 'Wait' : 'Submit',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                  );
                })),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          )
        ],
      ),
    );
  }
}
