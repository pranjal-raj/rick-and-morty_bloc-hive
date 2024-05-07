import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/favourites/ui/favourites.dart';
import '../features/home/bloc/home_bloc.dart';
import '../features/home/ui/home.dart';


class AppRoutes {

static Map<String, Widget Function(BuildContext)> routes = {
  "/" : (ctx)=> Home(homeBloc : ctx.read<HomeBloc>()),
  "/favourites" : (ctx)=> const Favourites()
};

}