import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class InicioScreen extends StatelessWidget {
  const InicioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Inicio"),
        backgroundColor: Colors.blueGrey[500],
        shadowColor: Colors.amber,
      ),
      body: Center(
        child: FutureBuilder(
          future: Future.delayed(
            const Duration(seconds: 0),
            () {
              return;
            },
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Column(
                children: const [],
              );
            }
            return FutureBuilder(
              future: Future.delayed(
                const Duration(milliseconds: 4300),
                () {
                  Navigator.of(context).pushReplacementNamed("login");
                },
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return Center(
                    child: Container(
                      color: Colors.blueGrey[600],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(300),
                            child: const Image(
                                image:
                                    AssetImage("assets/images/trueque2.png")),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          ZoomIn(
                              delay: const Duration(milliseconds: 3000),
                              child: const Text(
                                'GO SWAP',
                                style: TextStyle(
                                    fontFamily: 'Arial',
                                    fontSize: 50,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                          ZoomOut(
                            delay: const Duration(milliseconds: 3000),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: DefaultTextStyle(
                                style: const TextStyle(
                                  fontSize: 30.0,
                                  fontFamily: 'popin',
                                ),
                                child: Column(
                                  children: [
                                    FadeInLeft(
                                        duration:
                                            const Duration(milliseconds: 1500),
                                        delay:
                                            const Duration(milliseconds: 500),
                                        child: const Text('Comparte')),
                                    FadeInRight(
                                        duration:
                                            const Duration(milliseconds: 1500),
                                        delay:
                                            const Duration(milliseconds: 1000),
                                        child: const Text('Aprende')),
                                    FadeInLeft(
                                        duration:
                                            const Duration(milliseconds: 1500),
                                        delay:
                                            const Duration(milliseconds: 1500),
                                        child: const Text('Relacionate')),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return Container();
              },
            );
          },
        ),
      ),
    );
  }
}
