import 'package:flutter/material.dart';
import 'package:movie_bloc/src/routes/routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 66, 209, 9))),
    routes: AppRoutes.routes
    );
  }
}
