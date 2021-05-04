import 'package:flutter/material.dart';
import 'package:movies_app/src/models/actor_model.dart';
import 'package:movies_app/src/models/movie_model.dart';
import 'package:movies_app/src/providers/movie_provider.dart';

class MovieDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        _createAppBar(movie),
        SliverList(
            delegate: SliverChildListDelegate([
          SizedBox(
            height: 10.0,
          ),
          _titlePoster(context, movie),
          _description(movie),
          _createCast(movie),
        ]))
      ],
    ));
  }

  Widget _createAppBar(Movie movie) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          movie.title,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage(
          image: NetworkImage(movie.getBackgroundImage()),
          placeholder: AssetImage("assets/img/loading.gif"),
          fadeInDuration: Duration(milliseconds: 300),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _titlePoster(BuildContext context, Movie movie) {
    print(movie.uniqueId);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(children: [
        Hero(
          tag: movie.uniqueId,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image(
              image: NetworkImage(movie.getPosterImg()),
              height: 150.0,
            ),
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        Flexible(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              movie.title,
              style: Theme.of(context).textTheme.headline6,
              overflow: TextOverflow.ellipsis,
            ),
            Text(movie.originalTitle,
                style: Theme.of(context).textTheme.subtitle2,
                overflow: TextOverflow.ellipsis),
            Row(
              children: [
                Icon(Icons.star_border),
                Text(movie.voteAverage.toString(),
                    style: Theme.of(context).textTheme.subtitle2)
              ],
            )
          ],
        ))
      ]),
    );
  }

  Widget _description(Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _createCast(Movie movie) {
    final movieProvider = new MovieProvider();

    return FutureBuilder(
      future: movieProvider.getCast(movie.id.toString()),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return _createCastPageView(snapshot.data);
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _createCastPageView(List<Actor> actors) {
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
          itemCount: actors.length,
          pageSnapping: false,
          controller: PageController(viewportFraction: 0.3, initialPage: 1),
          itemBuilder: (context, i) => _actorCard(actors[i])),
    );
  }

  Widget _actorCard(Actor actor) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
                placeholder: AssetImage("assets/img/no-image.jpg"),
                image: NetworkImage(actor.getPhoto()),
                height: 150.0,
                fit: BoxFit.cover),
          ),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
