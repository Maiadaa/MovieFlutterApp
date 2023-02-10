import 'package:dartz/dartz.dart' as dartz;
import 'package:day8/PopularMoviesAPI.dart';
import 'package:day8/model/PopularMoviesError.dart';
import 'package:flutter/material.dart';
import 'package:image_card/image_card.dart';
import 'model/PopularMoviesSuccess.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<dynamic> fields = [];
  var favorites = <int>[];

  @override
  Widget build(BuildContext context) {
    void toggleFavorite(int id) {
      if (favorites.contains(id)) {
        favorites.remove(id);
      } else {
        favorites.add(id);
      }
    }

    Widget setIcon(id) {
      if (favorites.contains(id)) {
        return Icon(Icons.favorite) as Widget;
      } else {
        return Icon(Icons.favorite_border) as Widget;
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text("PopularMovies"), actions: [
        TextButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/Wishlist',
            );
          },
          child: Text("WISHLIST"),
        ),
        PopupMenuButton(
          //icon: Icon(Icons.more_vert),
            icon: Icon(Icons.sort),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text("Top Rated"),
                onTap: () {
                  setState(() {
                    fields.sort(
                            (a, b) => a.voteAverage.compareTo(b.voteAverage));
                  });
                },
              ),
              PopupMenuItem(
                child: Text("Popularity"),
                onTap: () {
                  setState(() {
                    fields.sort(
                            (a, b) => a.popularity.compareTo(b.popularity));
                  });
                },
              ),
            ])
      ]),
      body: SafeArea(
          child: FutureBuilder<
              dartz.Either<PopularMoviesError, PopularMoviesSuccess>>(
            future: PopularMoviesAPI.api.fetchPopularMovies(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                dartz.Either<PopularMoviesError, PopularMoviesSuccess> either =
                snapshot.data!;
                if (fields.isEmpty) {
                  either.fold((l) => null, (r) => fields = r.results!);
                }
                return either.fold(
                      (l) => Center(child: Text(l.statusMessage!)),
                      (r) => GridView.builder(
                    itemCount: fields.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, mainAxisExtent: 300),
                    itemBuilder: (context, index) => InkWell(
                      onTap: () => Navigator.pushNamed(context, '/MovieScreen',
                          arguments: fields[index].id),
                      child: Center(
                        child: FillImageCard(
                          height: 350,
                          contentPadding: const EdgeInsets.only(bottom: 3),
                          width: 175,
                          heightImage: 190,
                          imageProvider: NetworkImage(
                            "http://image.tmdb.org/t/p/w500${fields[index].posterPath!}",
                          ),
                          title: Text(fields[index].originalTitle!),
                          description: Text(fields[index].releaseDate!),
                          footer: Row(children: [
                            Row(
                              children: [
                                Text(fields[index].voteAverage!.toString()),
                                const Icon(Icons.star, size: 15),
                              ],
                            ),
                            const SizedBox(
                              width: 94,
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: setIcon(fields[index].id),
                                  iconSize: 20,
                                  color: Colors.purple,
                                  onPressed: () {
                                    setState(() {
                                      toggleFavorite(fields[index].id);
                                    });
                                  },
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("API error: ${snapshot.error.toString()}"),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )),
    );
  }
}
