part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitEvent extends HomeEvent {}

class HomeCharacterClickedEvent extends HomeEvent {}

class HomeCharacterFavouriteClickedEvent extends HomeEvent {
  final List<CharacterModel> characterList;
  final int index;

  HomeCharacterFavouriteClickedEvent({required this.index, required this.characterList});
}

class HomeFavouriteNavigateEvent extends HomeEvent {}
