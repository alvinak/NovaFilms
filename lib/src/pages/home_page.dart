import 'package:flutter/material.dart';
import 'package:novafilm/src/providers/movies_provider.dart';
import 'package:novafilm/src/widgets/card_swiper_widget.dart';
import 'package:novafilm/src/widgets/horizontal_cards.dart';

class HomePage extends StatelessWidget {
  final moviesProvider = MoviesProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Peliculas en cines'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperCards(),
            footer(context),
          ],
        ),
      ),
    );
  }

  Widget _swiperCards() {
    return FutureBuilder(
      future: moviesProvider.getMoviesInCinema(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(
            movies: snapshot.data,
          );
        } else {
          return Container(
            height: 700,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(left: 20),
              child: Text('Populares',
                  style: Theme.of(context).textTheme.subtitle1)),
          SizedBox(
            height: 5.0,
          ),
          FutureBuilder(
            future: moviesProvider.getPopularMovies(),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData) {
                return HorizontalCards(
                  movies: snapshot.data,
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}
