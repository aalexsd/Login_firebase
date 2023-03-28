import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Stack(
       children: [
         SizedBox(
           height: 350,
           child: ClipRRect(
             child: Image.asset('assets/images/flutterr.jpeg',
               fit: BoxFit.cover,),
           ),
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
                   ),
                   Padding(
                     padding: const EdgeInsets.only(top: 90),
                     child: SizedBox(
                       width: 280 ,
                       height: 40,
                       child: ElevatedButton(onPressed: (){},
                         style: ButtonStyle(
                           backgroundColor: MaterialStateProperty.all(Colors.blue),
                           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                               RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(30.0),
                                   side: const BorderSide(color: Colors.blue)
                               )
                           ),
                         ),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             IconButton(
                             icon: Image.asset('assets/images/google.webp'),
                             iconSize: 50,
                             onPressed: () {},
                           ),
                             const Text('Continue with Google',
                               style: TextStyle(
                                   fontSize: 17
                               ),
                             ),
                           ],
                         )
                       ),
                     ),
                   ),
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