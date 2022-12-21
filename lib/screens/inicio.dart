import 'package:flutter/material.dart';

class InicioScreen extends StatelessWidget {
  const InicioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 181, 166, 181),
      child: FractionallySizedBox(
        widthFactor: 0.99,
        heightFactor: 0.99,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white30,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.70,
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(70),
                child: Image(
                    fit: BoxFit.fill,
                    image: AssetImage("assets/images/trueque2.png")),
              ),
            ),
            SizedBox(height: 30),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.blueGrey[600],
              onPressed: () {},
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                child: Text(
                  'Login',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 10),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.blueGrey[600],
              onPressed: () {},
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 92, vertical: 15),
                child: Text(
                  'Registro',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
