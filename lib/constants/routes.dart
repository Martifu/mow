import 'package:flutter/material.dart';
import 'package:mow/ui/screens/home_screen.dart';
import 'package:mow/ui/screens/movies/movie_detail.dart';

final Map<String, WidgetBuilder> routes = {
  '/': (context) => const HomeScreen(),
  '/movie_detail': (context) => const MovieDetails(),
};
