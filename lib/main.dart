import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mow/ui/providers/movies_provider.dart';
import 'package:provider/provider.dart';

import 'constants/routes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MovieProvider()..fetchMovies()),
      ],
      child: MaterialApp(
        title: 'My Movies App',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          useMaterial3: true,
          textTheme: GoogleFonts.outfitTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        themeMode: ThemeMode.dark,
        routes: routes,
      ),
    );
  }
}
