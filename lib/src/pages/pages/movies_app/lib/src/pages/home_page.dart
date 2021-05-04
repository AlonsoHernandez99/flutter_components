import 'package:flutter/material.dart';
import 'package:movies_app/src/providers/movie_provider.dart';
import 'package:movies_app/src/search/search_delegate.dart';
import 'package:movies_app/src/widgets/card_swiper_widget.dart';
import 'package:movies_app/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {
  final moviesProvider = new MovieProvider();

  @override
  Widget build(BuildContext context) {
    moviesProvider.getPopular();

    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text("Theather Movies"),
          backgroundColor: Colors.indigoAccent,
          actions: [
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  showSearch(context: context, delegate: DataSearch());
                })
          ],
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [_swiperCards(), _footer(context)],
          ),
        ));
  }

  Widget _swiperCards() {
    return FutureBuilder(
      future: moviesProvider.getInTheathers(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        return snapshot.hasData
            ? CardSwiper(movies: snapshot.data)
            : Container(
                height: 400, child: Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              "Popular Movies",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          StreamBuilder(
            stream: moviesProvider.popularStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              return snapshot.hasData
                  ? MovieHorizontal(
                      movies: snapshot.data,
                      nextPage: moviesProvider.getPopular)
                  : Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }
}
