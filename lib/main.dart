import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mow/ui/providers/firestore_movies_provider.dart';
import 'package:mow/ui/providers/movies_provider.dart';
import 'package:mow/ui/providers/music_provider.dart';
import 'package:mow/ui/providers/push_notifications_provider.dart';
import 'package:provider/provider.dart';

import 'constants/routes.dart';
import 'firebase_options.dart';

PushNotificationProvider pushNotificationProvider = PushNotificationProvider();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  log('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  pushNotificationProvider.initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    pushNotificationProvider.onMessageListener();
    pushNotificationProvider.onTokenListener();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MovieProvider>(
            create: (_) => MovieProvider()..fetchMovies()),
        ChangeNotifierProvider<MusicProvider>(
            create: (_) => MusicProvider()..searchTracks("junior h")),
        ChangeNotifierProvider(create: (_) => FirestoreProvider()..getMovies()),
        ChangeNotifierProvider(
            create: (_) => PushNotificationProvider()..onTokenListener()),
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
