import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class InicioScreen extends StatelessWidget {
  const InicioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Inicio"),
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
                const Duration(seconds: 6),
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
                          SizedBox(
                            height: 10,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(300),
                            child: Image(
                                image:
                                    AssetImage("assets/images/trueque2.png")),
                          ),
                          SizedBox(
                            width: 250.0,
                            child: DefaultTextStyle(
                              style: const TextStyle(
                                fontSize: 30.0,
                                fontFamily: 'popin',
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.width * 0.10),
                                child: AnimatedTextKit(
                                    isRepeatingAnimation: true,
                                    animatedTexts: [
                                      TyperAnimatedText(
                                          'Comparte\nAprende\nRelacionate',
                                          speed: Duration(milliseconds: 150)),
                                      TyperAnimatedText('  Go Swap',
                                          speed: Duration(milliseconds: 10),
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ]),
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
