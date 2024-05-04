part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitEvent extends HomeEvent {}

class HomeCharacterClickedEvent extends HomeEvent {}

class HomeCharacterFavouriteClickedEvent extends HomeEvent {}

class HomeFavouriteNavigateEvent extends HomeEvent {}
