import 'package:day8/home2.dart';
import 'package:flutter/material.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({Key? key}) : super(key: key);

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  late Map<int, Movie> favorites;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    favorites = ModalRoute.of(context)!.settings.arguments as Map<int, Movie>;

    if (favorites!.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              color: Colors.white,
              Icons.arrow_back,
              size: 25,
            ),
          ),
          title: Text("PopularMovies"),
        ),
        body: Center(
          child: Text("No movies in wishlist yet"),
        ),
      );
    } else {
      Iterable<Movie> movies = favorites.values;
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              color: Colors.white,
              Icons.arrow_back,
              size: 25,
            ),
          ),
          title: Text("PopularMovies"),
        ),
        body: SafeArea(
          child: ListView.separated(
            separatorBuilder: (context, index) => Divider(),
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: movies.length,
            itemBuilder: (context, index) => Row(children: [
              Container(
                padding: EdgeInsets.all((width * 0.05)),
                child: Container(
                  padding: EdgeInsets.only(top: 15, bottom: 15),
                  color: Colors.black12,
                  child: Row(
                    children: [
                      Container(
                        height: height * 0.15,
                        width: width * 0.35,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              "http://image.tmdb.org/t/p/w500${movies.elementAt(index).poster}",
                            ),
                            fit: BoxFit.contain,
                            alignment: Alignment.center,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.39,
                        child: Column(
                          children: [
                            Text(
                              movies.elementAt(index).title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(movies.elementAt(index).date,
                                style: TextStyle(
                                  overflow: TextOverflow.visible,
                                  fontSize: 15,
                                )),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: width * 0.1,
                        child: Column(
                          children: [
                            Icon(Icons.favorite, color: Colors.pink),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: width * 0.055,
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      );
    }
  }
}
