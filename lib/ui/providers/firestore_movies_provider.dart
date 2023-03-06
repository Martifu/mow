import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mow/data/models/movie.dart';

class FirestoreProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Movie> myMovies = [];
  List<Movie> moviesWatched = [];
  Movie? movieSelected;
  Future<void> getMovies() async {
    final querySnapshot = await _firestore
        .collection('CODIGOS')
        .doc('LkNbRjLsPddukQDL26bz')
        .collection('peliculas')
        .get();

    myMovies =
        querySnapshot.docs.map((e) => Movie.fromFirestore(e.data())).toList();

    notifyListeners();
  }

  //listen to changes in the database
  Stream<List<Movie>> listenMovies() {
    return _firestore
        .collection('CODIGOS')
        .doc('LkNbRjLsPddukQDL26bz')
        .collection('peliculas')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((document) => Movie.fromFirestore(document.data()))
            .toList());
  }

  //Add a new movie to the database
  Future<void> addMovie(Movie movie) async {
    //add movie with his id and verify if the movie already exists
    movie.dateAdded = DateTime.now();
    movie.watched = false;
    await _firestore
        .collection('CODIGOS')
        .doc('LkNbRjLsPddukQDL26bz')
        .collection('peliculas')
        .doc(movie.id.toString())
        .set(movie.toFirestore());

    notifyListeners();
  }

  Future<void> deleteMovie(Movie movie) async {
    await _firestore
        .collection('CODIGOS')
        .doc('LkNbRjLsPddukQDL26bz')
        .collection('peliculas')
        .doc(movie.id.toString())
        .delete();

    notifyListeners();
  }

  //change the favorite status of a movie
  Future<void> changeFavoriteStatus(Movie movie) async {
    movie.watched = !movie.watched!;
    await _firestore
        .collection('CODIGOS')
        .doc('LkNbRjLsPddukQDL26bz')
        .collection('peliculas')
        .doc(movie.id.toString())
        .update({'watched': !movie.watched!});

    notifyListeners();
  }

  //Verify if the movie already exists
  Future<bool> movieExists(Movie movie) async {
    final querySnapshot = await _firestore
        .collection('CODIGOS')
        .doc('LkNbRjLsPddukQDL26bz')
        .collection('peliculas')
        .where('id', isEqualTo: movie.id)
        .get();

    movieSelected = querySnapshot.docs.isNotEmpty
        ? Movie.fromFirestore(querySnapshot.docs.first.data())
        : null;

    return querySnapshot.docs.isNotEmpty;
  }

  //verify if movie is watched
  Future<bool> movieWatched(Movie movie) async {
    final querySnapshot = await _firestore
        .collection('CODIGOS')
        .doc('LkNbRjLsPddukQDL26bz')
        .collection('peliculas')
        .where('id', isEqualTo: movie.id)
        .where('watched', isEqualTo: true)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }

  //toogle the watched status of a movie
  Future<void> toogleWatchedStatus(Movie movie) async {
    log('toogleWatchedStatus: ${movie.watched}');

    await _firestore
        .collection('CODIGOS')
        .doc('LkNbRjLsPddukQDL26bz')
        .collection('peliculas')
        .doc(movie.id.toString())
        .update({'watched': !movieSelected!.watched!});

    movieSelected!.watched = !movieSelected!.watched!;

    notifyListeners();
  }

  //get all movies watched
  Future<void> getMoviesWatched() async {
    final querySnapshot = await _firestore
        .collection('CODIGOS')
        .doc('LkNbRjLsPddukQDL26bz')
        .collection('peliculas')
        .where('watched', isEqualTo: true)
        .get();

    moviesWatched =
        querySnapshot.docs.map((e) => Movie.fromFirestore(e.data())).toList();

    notifyListeners();
  }
}
