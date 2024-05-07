part of 'favourites_bloc.dart';

@immutable
sealed class FavouritesState {}

sealed class FavouriteActionState {}

final class FavouritesInitial extends FavouritesState {}

class FavouritesLoadingState extends FavouritesState {}

class FavouritesSuccessState extends FavouritesState {
  final List<CharacterModel> favouriteCharactersList;

  FavouritesSuccessState({required this.favouriteCharactersList});
}

class FavouritesSuccessEmptyState extends FavouritesState {}

class FavouritesFailureState extends FavouritesState {
  final String errorMessage;

  FavouritesFailureState({required this.errorMessage});
}

class FavouritesCharacterListUpdated extends FavouritesState {
  final List<CharacterModel> charactersList;

  FavouritesCharacterListUpdated({required this.charactersList});
}
