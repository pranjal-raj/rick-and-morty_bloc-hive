import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../common/data/models/character_model.dart';
import '../../common/repository/rick_and_morty_repository_impl.dart';
import '../../common/network/api_service.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final repository = RickAndMortyRepositoryImpl(ApiService());
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitEvent>(homeInitEventHandler);
    on<HomeFavouriteNavigateEvent>(homeFavouriteNavigateEventHandler);
    on<HomeCharacterFavouriteClickedEvent>(
        homeCharacterFavouriteClickedEventHandler);
    on<HomeFavouritesListChangedEvent>(homeFavouritesListChangedEventHandler);
    on<HomeEndOfCharacterListReachedEvent>(
        homeEndOfCharacterListReachedEventHanlder);
  }

  FutureOr<void> homeFavouriteNavigateEventHandler(
      HomeFavouriteNavigateEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToFavouritesPageActionState());
  }

  FutureOr<void> homeInitEventHandler(
      HomeInitEvent event, Emitter<HomeState> emit) async {
    emit(LoadingState());
    try {
      final response = await repository.getAllCharacters();
      emit(SuccessState(charactersList: response));
    } on Exception catch (e) {
      debugPrint("Error:  ${e.toString()}");
      emit(FailureState(errorMessage: e.toString()));
    }
  }

  FutureOr<void> homeCharacterFavouriteClickedEventHandler(
      HomeCharacterFavouriteClickedEvent event, Emitter<HomeState> emit) async {
    try {
      if (!event.characterList[event.index].liked) {
        repository.updateCharacterLikedStatus(event.characterList[event.index]);
        repository.addToFavurites(event.characterList[event.index]);
      } else {
        repository.updateCharacterLikedStatus(event.characterList[event.index]);
        repository.removeFromfavourites(event.characterList[event.index]);
      }
      emit(SuccessState(charactersList: event.characterList));
    } on Exception catch (e) {
      debugPrint("Failure to add : ${e.toString()}");
    }
  }

  FutureOr<void> homeFavouritesListChangedEventHandler(
      HomeFavouritesListChangedEvent event, Emitter<HomeState> emit) {
    emit(HomeFavouritesListChangedState());
  }

  FutureOr<void> homeEndOfCharacterListReachedEventHanlder(
      HomeEndOfCharacterListReachedEvent event, Emitter<HomeState> emit) async {
    try {
      final characterListPage = await repository.getPagedCharacters(event.page);
      emit(HomeNewPagesAddedState(characterList: characterListPage, pageKey: event.page));
    } on Exception catch (e) {
      print("Nigga:  ${e.toString()}");
      emit(FailureState(errorMessage: e.toString()));
    }
  }
}
