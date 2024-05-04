import 'package:flutter/material.dart';

import '../features/favourites/ui/favourites.dart';
import '../features/home/ui/home.dart';


class AppRoutes {

static Map<String, Widget Function(BuildContext)> routes = {
  "/" : (ctx)=> Home(),
  "/favourites" : (ctx)=> Favourites()
};

}