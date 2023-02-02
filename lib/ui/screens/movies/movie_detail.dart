import 'package:flutter/material.dart';
import 'package:mow/data/models/movie.dart';

class MovieDetails extends StatelessWidget {
  const MovieDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var movie = ModalRoute.of(context)!.settings.arguments as Movie;
    return Scaffold(
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
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(movie.overview,
              style: const TextStyle(fontSize: 13, color: Colors.white)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SizedBox(
            width: size.width,
            height: 30,
            child: ElevatedButton(
                onPressed: () {
                  // launchUrl(movie.video)
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
