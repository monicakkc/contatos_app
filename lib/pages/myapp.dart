import 'package:contatosapp/pages/contato_back_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: Theme.of(context).appBarTheme.copyWith(
            color: Colors.orange,),
         colorScheme: const ColorScheme.light(
           primary: Colors.orange,secondary: Color.fromARGB(255, 137, 96, 96),
           background: Color.fromARGB(255, 207, 192, 192)),
          textTheme: GoogleFonts.robotoTextTheme(),
    ),
      home:  const ContatoBackPage(),
    );
  }
}