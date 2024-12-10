
import 'package:dauys_remote/api/api.dart';
import 'package:dauys_remote/features/gateway/gateway_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'firebase_options.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'features/auth/auth_geateway_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    Phoenix(
      child: const MyApp(),
    ),
  );}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DAUYS Remote',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        FlutterI18nDelegate(
          translationLoader: FileTranslationLoader(
            basePath: 'assets/i18n',
            fallbackFile: 'ru',
          ),
        ),
      ],
      supportedLocales: const [
        Locale('ru', ''),
        Locale('en', ''),
        Locale('kz', ''),
      ],
      locale: const Locale('ru'),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AuthCheckScreen(),
    );
  }
}

class AuthCheckScreen extends StatelessWidget {
  const AuthCheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Api>(
      future: Api.create(), // Wait for the async creation
      builder: (BuildContext context, AsyncSnapshot<Api> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while waiting
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const AuthGeatewayScreen();
        } else if (snapshot.hasData) {
          // Api is ready, navigate to the appropriate screen
          return const GateWayScreen();
        } else {
          // Fallback for unexpected cases
          return const Center(child: Text('Unexpected state'));
        }
      },
    );
  }
}
