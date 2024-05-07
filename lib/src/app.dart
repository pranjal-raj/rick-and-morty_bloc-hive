import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_bloc/src/routes/routes.dart';

import 'features/home/bloc/home_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                  seedColor: const Color.fromARGB(255, 66, 209, 9))),
          routes: AppRoutes.routes),
    );
  }
}
