import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:movie_bloc/src/features/common/data/models/character_model.dart';
import 'package:movie_bloc/src/features/common/network/api_service.dart';
import 'package:movie_bloc/src/features/common/repository/rick_and_morty_repository_impl.dart';
import 'package:movie_bloc/src/features/home/bloc/home_bloc.dart';


part 'favourites_event.dart';
part 'favourites_state.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  final repository = RickAndMortyRepositoryImpl(ApiService());
  FavouritesBloc() : super(FavouritesInitial()) {
    on<FavouritesInitEvent>(favouritesInitEventHandler);

    on<FavouritesCharacterFavouriteClickedEvent>(
        favouritesCharacterFavouriteClickedEventHandler);
  }

  FutureOr<void> favouritesInitEventHandler(FavouritesInitEvent event, Emitter<FavouritesState> emit) async {
    emit(FavouritesLoadingState());
    try {
      final favouriteCharactersList = await repository.getAllFavourites();
      if (favouriteCharactersList.isEmpty) {
        emit(FavouritesSuccessEmptyState());
      } else {
        emit(FavouritesSuccessState(favouriteCharactersList: favouriteCharactersList));
      }
    } on Exception catch (e) {
      emit(FavouritesFailureState(errorMessage: e.toString()));
    }
  }

  FutureOr<void> favouritesCharacterFavouriteClickedEventHandler(FavouritesCharacterFavouriteClickedEvent event, Emitter<FavouritesState> emit) async {
    
    try {
      if (!event.characterList[event.index].liked) {
        repository.updateCharacterLikedStatus(event.characterList[event.index]);
        repository.addToFavurites(event.characterList[event.index]);
      } else {
        repository.updateCharacterLikedStatus(event.characterList[event.index]);
        repository.removeFromfavourites(event.characterList[event.index]);
      }

      final favouriteCharactersList = await repository.getAllFavourites();
      if(favouriteCharactersList.isNotEmpty)
      {
        emit(FavouritesSuccessState(favouriteCharactersList: favouriteCharactersList));
      }
      else{
        emit(FavouritesSuccessEmptyState());
      }
      event.bloc.add(HomeFavouritesListChangedEvent());

    } on Exception catch (e) {
      debugPrint("Failure to add : ${e.toString()}");
    }
  }
}
