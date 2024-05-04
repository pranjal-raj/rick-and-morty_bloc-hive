import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:movie_bloc/src/features/common/data/character_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {
      
    });

    on<HomeFavouriteNavigateEvent>(homeFavouriteNavigateEventHandler);
  }

  FutureOr<void> homeFavouriteNavigateEventHandler(HomeFavouriteNavigateEvent event, Emitter<HomeState> emit) {
    print("Navigate Clicked");
    emit(HomeNavigateToFavouritesPageActionState());
  }
}
