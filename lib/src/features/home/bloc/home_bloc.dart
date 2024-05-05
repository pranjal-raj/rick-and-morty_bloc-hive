import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:movie_bloc/src/features/common/data/character_model.dart';
import 'package:movie_bloc/src/features/common/data/favourited_characters.dart';
import 'package:movie_bloc/src/features/common/repository/rick_and_morty_repository_impl.dart';

import '../../common/network/api_service.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final repository = RickAndMortyRepositoryImpl(ApiService());
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitEvent>(homeInitEventHandler);

    on<HomeFavouriteNavigateEvent>(homeFavouriteNavigateEventHandler);

    on<HomeCharacterFavouriteClickedEvent>(homeCharacterFavouriteClickedEventHandler);
  }

  FutureOr<void> homeFavouriteNavigateEventHandler(
      HomeFavouriteNavigateEvent event, Emitter<HomeState> emit) {
    print("Navigate Clicked");
    emit(HomeNavigateToFavouritesPageActionState());
  }

  FutureOr<void> homeInitEventHandler(
      HomeInitEvent event, Emitter<HomeState> emit) async {
    print("handler called");
    emit(LoadingState());

    try {
      final response = await repository.getAllCharacters();
      emit(SuccessState(charactersList: response));
    } on Exception catch (e) {
      emit(FailureState(errorMessage: e.toString()));
    }
  }

  FutureOr<void> homeCharacterFavouriteClickedEventHandler(HomeCharacterFavouriteClickedEvent event, Emitter<HomeState> emit) async {
    try {
      if (!event.characterList[event.index].liked) {
        repository.updateCharacterLikedStatus(event.characterList[event.index]);
        repository.addToFavurites(event.characterList[event.index]);
      } else {
        repository.updateCharacterLikedStatus(event.characterList[event.index]);
        repository.removeFromfavourites(event.characterList[event.index]);
      }
      print("Favourites : ${favourites.length}");
      emit(HomeCharacterListUpdated(charactersList: event.characterList));
    } on Exception catch (e){
      print("failure to add : ${e.toString()}");
    }
  }
}
