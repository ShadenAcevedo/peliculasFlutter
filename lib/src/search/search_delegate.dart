import 'package:flutter/material.dart';
import 'package:peliculas_app/src/models/movie_model.dart';
import 'package:peliculas_app/src/providers/movies_provider.dart';

class DataSearch extends SearchDelegate {
  String seleccion = '';
  final peliculasProvider = PeliculasProvider();

  final peliculas = [
    'IronMan',
    'IronMan2',
    'IronMan3',
    'Mujer Maravilla',
    'SuperMan',
    'AquaMan',
    'Holk',
    'Thor',
    'Batallta Naval'
  ];

  final peliculaRecientes = ['IronMan', 'Mujer Maravilla'];

  @override
  List<Widget> buildActions(BuildContext context) {
    // Son las acciones del appBar, como cerrar o la 'x'
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Es el icono a la izquierda del appBar, como el icono de buscador o '<'
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados que se van a mostrar
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        child: Text(seleccion),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Son las sugerencias que aparecen cuando la persona escribe

    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
        future: peliculasProvider.buscarPelicula(query),
        builder: (context, AsyncSnapshot<List<Pelicula>> snapshot) {
          if (snapshot.hasData) {
            final peliculas = snapshot.data;

            return ListView(
              children: peliculas.map((pelicula) {
                return ListTile(
                  leading: FadeInImage(
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    image: NetworkImage(pelicula.getPosterImg()),
                    width: 50.0,
                    fit: BoxFit.contain,
                  ),
                  title: Text(pelicula.title),
                  subtitle: Text(
                    pelicula.overview,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () {
                    close(context, null);
                    pelicula.uniqueId = '';
                    Navigator.pushNamed(context, 'detail', arguments: pelicula);
                  },
                );
              }).toList(),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });

    // final listaSugerida = (query.isEmpty)
    //     ? peliculaRecientes
    //     : peliculas
    //         .where((palabra) => palabra.toLowerCase().startsWith(query))
    //         .toList();
    // return ListView.builder(
    //     itemCount: listaSugerida.length,
    //     itemBuilder: (context, i) {
    //       return ListTile(
    //         leading: Icon(Icons.movie_filter_sharp),
    //         title: Text(listaSugerida[i]),
    //         onTap: () {
    //           seleccion = listaSugerida[i];
    //           showResults(context);
    //         },
    //       );
    //     });
  }
}
