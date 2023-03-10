import 'package:readmore/readmore.dart';
import 'package:day8/MovieDetailsAPI.dart';
import 'package:day8/model/MovieDetailsError.dart';
import 'package:day8/model/MovieDetailsSuccess.dart';
import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart' as dartz;

class MovieScreen extends StatefulWidget {
  const MovieScreen({Key? key}) : super(key: key);

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: FutureBuilder<
              dartz.Either<MovieDetailsError, MovieDetailsSuccess>>(
        future: MovieDetailsAPI.api.fetchMovieDetail(
            ModalRoute.of(context)!.settings.arguments as int),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            dartz.Either<MovieDetailsError, MovieDetailsSuccess> either =
                snapshot.data!;
            return either.fold(
              (l) => Center(child: Text(l.statusMessage!)),
              (r) => Column(children: [
                SizedBox(
                  height: 250,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.network(
                            height: 250,
                            "http://image.tmdb.org/t/p/w500${r.backdropPath}",
                            fit: BoxFit.cover),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            '${r.title}',
                            style: const TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(15),
                        child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              color: Colors.white,
                              Icons.arrow_back,
                              size: 25,
                            )),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all((width * 0.05)),
                              child: Container(
                                color: Colors.black12,
                                child: Row(
                                  children: [
                                    Container(
                                      height: height * 0.3,
                                      width: width * 0.45,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            "http://image.tmdb.org/t/p/w500${r.posterPath}",
                                          ),
                                          fit: BoxFit.fill,
                                          alignment: Alignment.center,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: width * 0.45,
                                      child: Column(
                                        children: [
                                          Text(r.title!,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(r.releaseDate!,
                                              style: const TextStyle(
                                                fontSize: 15,
                                              )),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.star,
                                                size: 15,
                                              ),
                                              Text(r.voteAverage!.toString(),
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                  )),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 25, bottom: 10),
                          child: Row(
                            children: const [
                              Text(
                                "Overview",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.purple),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.only(left: 25, right: 25),
                            child: ReadMoreText(
                              r.overview.toString(),
                              style: TextStyle(fontSize: 16),
                              trimLines: 3,
                              colorClickableText: Colors.pink,
                              trimMode: TrimMode.Line,
                              trimCollapsedText: 'Show more',
                              trimExpandedText: 'Show less',
                              moreStyle: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            )),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 25, top: 20, bottom: 10),
                          child: Row(
                            children: const [
                              Text(
                                "Trailer",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.purple),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            color: Colors.black,
                            width: width * 0.86,
                            height: 200,
                            padding: const EdgeInsets.only(left: 25, right: 25),
                            child: Row(
                              children: [Text("Hi")],
                            )),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 25, top: 20, bottom: 10),
                          child: Row(
                            children: const [
                              Text(
                                "Reviews",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.purple),
                              ),
                            ],
                          ),
                        ),
                        ListView.separated(
                          itemCount: 1,
                          separatorBuilder: (context, index) => Divider(),
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) =>
                              ListTile(
                            contentPadding: EdgeInsets.only(
                              left: 25,
                              right: 25,
                            ),
                            title: Text("Screen Zealots \nA screen zealots review",
                                style: TextStyle(
                                  color: Colors.pink,
                                )),
                            subtitle: Text("www.screenzealots.com"),
                            trailing: Column(
                              children: [
                                Text("Vote Average: ${r.voteAverage}\nVotes Count: ${r.voteCount}\nPopularity: ${r.popularity}"),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        )
                      ]),
                    ),
                  ),
                ),
              ]),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.pink,
        child: const Icon(
          Icons.favorite,
          color: Colors.white,
        ),
      ),
    );
  }
}
