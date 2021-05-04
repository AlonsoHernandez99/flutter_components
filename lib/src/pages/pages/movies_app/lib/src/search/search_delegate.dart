import 'package:flutter/material.dart';
import 'package:movies_app/src/models/movie_model.dart';
import 'package:movies_app/src/providers/movie_provider.dart';

class DataSearch extends SearchDelegate {
  final movies = [
    'Avengers',
    'Endgame',
    'Capitan America',
    'Shazam',
    'Justice League',
    'Sonic'
  ];

  final recentMovies = ['GvsK', 'Tom and Jerry', 'Wanda Vision'];

  String selection = '';

  final moviesProvider = new MovieProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear_rounded),
          onPressed: () {
            query = "";
          }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.blueAccent,
        child: Text(selection),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) return Container();

    return FutureBuilder(
      future: moviesProvider.searchMovie(query),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());

        final movies = snapshot.data;

        return ListView(
            children: movies.map((movie) {
          return ListTile(
            leading: FadeInImage(
              image: NetworkImage(movie.getPosterImg()),
              placeholder: AssetImage("assets/img/no-image.jpg"),
              width: 50.0,
              fit: BoxFit.contain,
            ),
            title: Text(movie.title),
            subtitle: Text(movie.originalTitle),
            onTap: () {
              close(context, null);
              movie.uniqueId = "";
              Navigator.pushNamed(context, '/detail', arguments: movie);
            },
          );
        }).toList());
      },
    );
  }
}
