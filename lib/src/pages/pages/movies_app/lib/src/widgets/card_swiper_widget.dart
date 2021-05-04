import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movies_app/src/models/movie_model.dart';
import 'package:uuid/uuid.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;
  CardSwiper({@required this.movies});

  @override
  Widget build(BuildContext context) {
    final _screeSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          movies[index].uniqueId = Uuid().v1();
          return Hero(
            tag: movies[index].uniqueId,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: GestureDetector(
                  child: FadeInImage(
                      image: NetworkImage(movies[index].getPosterImg()),
                      placeholder: AssetImage("assets/img/no-image.jpg"),
                      fit: BoxFit.cover),
                  onTap: () => Navigator.pushNamed(context, "/detail",
                      arguments: movies[index]),
                )),
          );
        },
        itemCount: 3,
        itemWidth: _screeSize.width * 0.7,
        itemHeight: _screeSize.height * 0.5,
        layout: SwiperLayout.STACK,
      ),
    );
  }
}
