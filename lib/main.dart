import 'package:flutter/material.dart';
import 'package:inuny/pages/detail_page.dart';
import 'package:inuny/pages/home_page.dart';
import 'package:inuny/pages/log_page.dart';
import 'package:inuny/pages/shopp_page.dart';
import 'package:inuny/pages/sing_page.dart';
import 'package:provider/provider.dart';

import 'data/Provider/shopping_cart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const MaterialColor primaryColor = MaterialColor(0xFF33C283, <int, Color>{
      50: Color(0xFFE5F6EA),
      100: Color(0xFFBFEAD3),
      200: Color(0xFF8FDBB6),
      300: Color(0xFF5FCB99),
      400: Color(0xFF42C088),
      500: Color(0xFF33C283),
      600: Color(0xFF2CBF7A),
      700: Color(0xFF24BA6D),
      800: Color(0xFF1CB762),
      900: Color(0xFF0DB24F),
    });

    return ChangeNotifierProvider<Cart>(create: (context) => Cart(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Inuny',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF3F3F3),
        primaryColor: const Color(0xFF33C283),
        primarySwatch: primaryColor,
        textTheme: const TextTheme(
          headline1: TextStyle(fontFamily: 'Inter', color: Color(0xFF8C8C8C)),
          headline2: TextStyle(fontFamily: 'Inter', color: Color(0xFF8C8C8C)),
          headline3: TextStyle(fontFamily: 'Inter', color: Color(0xFF8C8C8C)),
          headline4: TextStyle(fontFamily: 'Inter', color: Color(0xFF8C8C8C)),
          headline5: TextStyle(fontFamily: 'Inter', color: Color(0xFF8C8C8C)),
          headline6: TextStyle(fontFamily: 'Inter', color: Color(0xFF8C8C8C)),
          subtitle1: TextStyle(fontFamily: 'Inter', color: Color(0xFF8C8C8C)),
          subtitle2: TextStyle(fontFamily: 'Inter', color: Color(0xFF8C8C8C)),
          bodyText1: TextStyle(fontFamily: 'Inter', color: Color(0xFF8C8C8C)),
          bodyText2: TextStyle(fontFamily: 'Inter', color: Color(0xFF8C8C8C)),
          button: TextStyle(
              fontFamily: 'Inter', color: Color(0xFFFFFFFF), fontSize: 12),
          caption: TextStyle(fontFamily: 'Inter', color: Color(0xFF8C8C8C)),
          overline: TextStyle(fontFamily: 'Inter', color: Color(0xFF8C8C8C)),
        ),
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.white, // Aquí estableces el color de la flecha de regreso para todo el tema
          ),
          // Resto del código del AppBarTheme
        ),
      ),
      home: const LogPage(),
      initialRoute: '/',
      routes: {
        '/sing': (context) => SingPage(),
        '/home': (context) => HomePage(),
        '/details': (context) => DetailPage(),
        '/shopp': (context) => ShoppPage(),
      },
    ));

  }
}
