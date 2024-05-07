part of 'home_bloc.dart';

@immutable
sealed class HomeState {}
sealed class HomeActionState extends HomeState {}

final class HomeInitial extends HomeActionState {}

//APIStates
class LoadingState extends HomeState {
}

class SuccessState extends HomeState{
  final List<CharacterModel> charactersList;

  SuccessState({required this.charactersList});
}

class FailureState extends HomeState {
  final String errorMessage;

  FailureState({required this.errorMessage});

}


//Navigate
class HomeNavigateToFavouritesPageActionState extends HomeActionState{}


class HomeFavouritesListChangedState extends HomeActionState{}

