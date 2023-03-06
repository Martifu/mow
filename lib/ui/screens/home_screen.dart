import 'package:flutter/material.dart';
import 'package:mow/ui/providers/firestore_movies_provider.dart';
import 'package:mow/ui/providers/music_provider.dart';
import 'package:provider/provider.dart';

import '../providers/movies_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MovieProvider>(context);
    var musicProvider = Provider.of<MusicProvider>(context);
    var firestoreProvider = Provider.of<FirestoreProvider>(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(provider.title!),
          actions: [
            FutureBuilder(
              future: firestoreProvider.getMoviesWatched(),
              builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
                return Text(firestoreProvider.moviesWatched.length.toString());
              },
            ),
          ],
        ),
        body: SizedBox(
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Row(
                  children: [
                    const Text(
                      "Peliculas por ver",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                      ),
                    ),
                  ],
                ),
              ),
              MoviesSlider(size: size, provider: provider),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Row(
                  children: [
                    const Text(
                      "Canciones pendientes",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.3,
                width: size.width,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: musicProvider.songs
                        .map((e) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Stack(
                                children: [
                                  Container(
                                    width: size.width * 0.4,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image:
                                            NetworkImage(e.album.images[0].url),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: size.width * 0.15,
                                          height: size.width * 0.15,
                                          child: IconButton(
                                            color: Colors.white,
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.black),
                                            ),
                                            onPressed: () {
                                              musicProvider
                                                  .playSong(e.previewUrl);
                                            },
                                            icon: musicProvider.isPlaying &&
                                                    musicProvider.songPlaying ==
                                                        e.previewUrl
                                                ? const Icon(Icons.pause,
                                                    size: 35)
                                                : const Icon(Icons.play_arrow,
                                                    size: 35),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      width: size.width * 0.27,
                                      height: size.height * 0.05,
                                      decoration: const BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                        ),
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 1),
                                          child: Text(
                                            e.name,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

class MoviesSlider extends StatelessWidget {
  const MoviesSlider({
    super.key,
    required this.size,
    required this.provider,
  });

  final Size size;
  final MovieProvider provider;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.3,
      width: size.width,
      child: PageView(
        allowImplicitScrolling: true,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: provider.movies
            .map(
              (movie) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black54,
                        blurRadius: 10,
                        spreadRadius: 1,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/movie_detail',
                          arguments: movie);
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Row(
                        children: [
                          Image.network(
                              'https://tmdb.org/t/p/w200${movie.posterPath}'),
                          Expanded(
                            child: Stack(
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.black,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(movie.title,
                                            style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            )),
                                        const SizedBox(height: 10),
                                        Text(movie.overview,
                                            maxLines: 5,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w100,
                                            )),
                                        const SizedBox(height: 3),
                                        Text(
                                            '${movie.releaseDate.day}/${movie.releaseDate.month}/${movie.releaseDate.year}',
                                            style: const TextStyle(
                                              fontSize: 10,
                                              color: Colors.grey,
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 10,
                                  right: 10,
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        size: 13,
                                        color: Colors.yellow,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        movie.voteAverage.toString(),
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
