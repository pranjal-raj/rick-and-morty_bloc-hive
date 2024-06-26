part of 'favourites_bloc.dart';

@immutable
sealed class FavouritesEvent {}

class FavouritesInitEvent extends FavouritesEvent {}

class FavouritesCharacterFavouriteClickedEvent extends FavouritesEvent {
  final List<CharacterModel> characterList;
  final int index;
  final HomeBloc bloc;
  
  FavouritesCharacterFavouriteClickedEvent({required this.index, required this.characterList, required this.bloc});
}
