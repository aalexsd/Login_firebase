import 'package:flutter/material.dart';

class AboutMe extends StatelessWidget {
  const AboutMe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Function will be called in restricted screen
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            SizedBox(
              height: 70,
              child: Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Text(
                  'Sobre mim',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'E aí, pessoal! Me chamo Alex Duarte e sou um entusiasta de tecnologia! Com 22 anos de idade, já tenho 5 anos de experiência no mercado de tecnologia - posso dizer que já vi um pouco de tudo nessa área.\n'
                    '\nE durante esse percurso, percebi que a minha verdadeira vocação é programar em mobile, especialmente em Flutter. Me amarro na maneira como ele torna a criação de aplicativos móveis elegante e eficiente. Para mim, programar em Flutter é como construir uma casa com Lego - divertido e desafiador ao mesmo tempo.  \n'
                    '\nAlém disso, sou uma pessoa tranquila, sempre aberta a novas ideias e gosto de trabalhar em equipe. Gosto de aprender e me aperfeiçoar sempre que posso - por isso, estou sempre procurando novos desafios e oportunidades para crescer.\n'
                    '\nEntão, se você está procurando um desenvolvedor mobile com muita vontade e dedicação, é só me chamar que eu estou pronto para ajudar!',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
            CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage('assets/images/avatar.png'),
            ),
            SizedBox(
              height: 300,
            )
          ],
        ),
      ),
    );
  }
}
