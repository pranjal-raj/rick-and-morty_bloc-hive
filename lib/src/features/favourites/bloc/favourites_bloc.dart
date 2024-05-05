import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_bloc/src/features/common/data/character_model.dart';
import 'package:movie_bloc/src/features/common/network/api_service.dart';
import 'package:movie_bloc/src/features/common/repository/rick_and_morty_repository_impl.dart';

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
    emit(LoadingState());
    try {
      final favouriteCharactersList = await repository.getAllFavourites();
      if (favouriteCharactersList.isEmpty) {
        emit(SuccessEmptyState());
      } else {
        emit(SuccessState(favouriteCharactersList: favouriteCharactersList));
      }
    } on Exception catch (e) {
      emit(FailureState(errorMessage: e.toString()));
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
      emit(SuccessState(favouriteCharactersList: favouriteCharactersList ));
    } on Exception catch (e) {
      print("failure to add : ${e.toString()}");
    }
  }
}
