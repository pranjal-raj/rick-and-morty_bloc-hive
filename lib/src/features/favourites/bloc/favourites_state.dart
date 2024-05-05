part of 'favourites_bloc.dart';

@immutable
sealed class FavouritesState {}

sealed class FavouriteActionState {}

final class FavouritesInitial extends FavouritesState {}

class LoadingState extends FavouritesState {}

class SuccessState extends FavouritesState {
  final List<CharacterModel> favouriteCharactersList;

  SuccessState({required this.favouriteCharactersList});
}

class SuccessEmptyState extends FavouritesState {}

class FailureState extends FavouritesState {
  final String errorMessage;

  FailureState({required this.errorMessage});
}


class FavouritesCharacterListUpdated extends FavouritesState {
  final List<CharacterModel> charactersList;

  FavouritesCharacterListUpdated({required this.charactersList});
}
