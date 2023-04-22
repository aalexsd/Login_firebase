import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // function which wil be called in home screen
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 70,
              child: Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Text(
                  'Sobre nós',
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Capyba is a design-driven software studio. We work with technology, design and innovation to create, co-create and transform the digital business of global enterprises.\n'
                    '\nOur multidisciplinary team of professionals is ready and motivated to solve numerous types of problem. Our curiosity challenges us every day to deliver unique solutions with our own design process.\n',
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontSize: 20, color: Colors.black),
              ),
            ),
            SizedBox(
              height: 200,
              width: 200,
              child: ClipRRect(
                child:
                Image.asset('assets/images/capyba.png'),
              ),
            ),
            const SizedBox(
              height: 300,
            )
          ],
        ),
      ),
    );
  }
}
