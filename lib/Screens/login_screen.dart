import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Stack(
       children: [
         ClipRRect(
           child: Image.asset('assets/images/newera.jpeg',
             fit: BoxFit.fill,),
         ),
         Padding(
           padding: const EdgeInsets.only(top: 250,
           left: 30),
           child: Text('Sign in',
           style: TextStyle(
             fontSize: 25,
             color: Colors.white,
             fontWeight: FontWeight.bold,
           ),),
         ),
         Column(
           mainAxisAlignment: MainAxisAlignment.end,
           children: [
             Container(
               height: 550,
               decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.circular(60),
               ),
               child: Column(
                 children: [
                   Padding(
                     padding: const EdgeInsets.only(top: 60,
                     left: 10,
                     right: 30),
                     child: TextFormField(
                       decoration: InputDecoration(
                         enabledBorder: UnderlineInputBorder(
                           borderSide: BorderSide(
                             width: 0.2, color: Colors.amber
                           ),
                         ),
                         prefixIcon: Icon(Icons.mail),
                         hintText: 'Username'
                       ),
                     ),
                   ),
                   Padding(
                     padding: const EdgeInsets.only(top: 20,
                         left: 10,
                         right: 30),
                     child: TextFormField(
                       decoration: InputDecoration(
                           enabledBorder: UnderlineInputBorder(
                             borderSide: BorderSide(
                                 width: 0.2, color: Colors.amber
                             ),
                           ),
                           prefixIcon: Icon(Icons.lock),
                           hintText: 'Password'
                       ),
                       obscureText: true,
                       enableSuggestions: false,
                       autocorrect: false,
                     ),
                   ),
                   Padding(
                     padding: const EdgeInsets.only(top: 40),
                     child: SizedBox(
                       width: 300,
                       height: 60,
                       child: ElevatedButton(onPressed: (){},
                          style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.deepPurpleAccent),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: const BorderSide(color: Colors.deepPurpleAccent)
                          )
                          ),
                          ),
                           child: const Text('Login',
                           style: TextStyle(
                             fontSize: 17
                           ),
                           ),
                       ),
                     ),
                   ),
                   Padding(
                     padding: const EdgeInsets.only(top: 10),
                     child: Text('Forgot your password?',
                     style: TextStyle(
                       color: Colors.grey
                     ),),
                   )
                 ],
               ),
             )
           ],
         )
       ],
     )
    );
    }
}