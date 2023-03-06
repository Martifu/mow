import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:mow/data/models/movie.dart';
import 'package:mow/ui/providers/firestore_movies_provider.dart';
import 'package:mow/ui/providers/movies_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetails extends StatelessWidget {
  const MovieDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var movie = ModalRoute.of(context)!.settings.arguments as Movie;
    var movieProvider = Provider.of<MovieProvider>(context);
    var firestoreProvider = Provider.of<FirestoreProvider>(context);
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FadeIn(
          child: FutureBuilder(
            future: firestoreProvider.movieExists(movie),
            initialData: false,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    heroTag: 'btn1',
                    onPressed: () {
                      snapshot.data
                          ? firestoreProvider.deleteMovie(movie)
                          : firestoreProvider.addMovie(movie);
                    },
                    child: snapshot.data
                        ? const Icon(Icons.remove)
                        : const Icon(Icons.add),
                  ),
                  const SizedBox(width: 10),
                  FadeIn(
                    animate: snapshot.data,
                    child: FutureBuilder(
                        future: firestoreProvider.movieWatched(movie),
                        builder: (BuildContext context,
                            AsyncSnapshot snapshotWatched) {
                          if (snapshotWatched.hasData) {
                            return FloatingActionButton(
                              heroTag: 'btn2',
                              onPressed: () {
                                firestoreProvider.toogleWatchedStatus(movie);
                              },
                              child: snapshotWatched.data
                                  ? const Icon(Icons.remove_red_eye)
                                  : const Icon(Icons.remove_red_eye_outlined),
                            );
                          }
                          return const SizedBox();
                        }),
                  ),
                ],
              );
            },
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: size.height * 0.45,
              child: Stack(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: size.height * 0.28,
                        width: size.width,
                        child: Image.network(
                          'https://tmdb.org/t/p/w500${movie.backdropPath}',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        height: size.height * 0.28,
                        width: size.width,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black87,
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: size.height * 0.18,
                    left: size.width * 0.05,
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            blurRadius: 10,
                            spreadRadius: 1,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: SizedBox(
                          width: size.width * 0.3,
                          child: Image.network(
                            'https://tmdb.org/t/p/w300${movie.posterPath}',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: size.height * 0.3,
                    left: size.width * 0.4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: size.width * 0.55,
                          child: Text(movie.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 25, color: Colors.white)),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 15,
                            ),
                            Text(movie.voteAverage.toString(),
                                style: const TextStyle(
                                    fontSize: 13, color: Colors.white)),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                                '${movie.releaseDate.day}/${movie.releaseDate.month}/${movie.releaseDate.year}',
                                style: const TextStyle(
                                    fontSize: 13, color: Colors.grey)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: size.height * 0.05,
                    left: size.width * 0.05,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(movie.overview,
                  style: const TextStyle(fontSize: 14, color: Colors.white)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: SizedBox(
                width: size.width,
                height: 30,
                child: ElevatedButton(
                    onPressed: () {
                      movieProvider.getTrailer(movie.id).then((value) {
                        if (value != '') {
                          launchUrl(Uri.parse(value));
                        }
                      });
                    },
                    child: const Text(
                      'Ver Trailer',
                      style: TextStyle(color: Colors.white),
                    )),
              ),
            )
          ],
        ));
  }
}
