import 'package:flutter/material.dart';

import 'package:peliculas_app/src/pages/home_page.dart';
import 'package:peliculas_app/src/pages/movie_detail_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Películas',
      initialRoute: '/home',
      routes: {
        '/home': (BuildContext context) => HomePage(),
        'detail': (BuildContext context) => MovieDetail(),
      },
    );
  }
}
