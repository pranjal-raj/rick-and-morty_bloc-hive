import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_bloc/src/features/common/ui/common_widgets.dart';
import 'package:movie_bloc/src/features/favourites/bloc/favourites_bloc.dart';
import '../../common/data/models/character_model.dart';
import '../../common/ui/character_card.dart';
import '../../home/bloc/home_bloc.dart';

class Favourites extends StatefulWidget {
  const Favourites({super.key});

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  final favouritesBloc = FavouritesBloc();

  @override
  void initState() {
    favouritesBloc.add(FavouritesInitEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavouritesBloc, FavouritesState>(
      bloc: favouritesBloc,
      listenWhen: (previous, current) => current is FavouriteActionState,
      buildWhen: (previous, current) => current is! FavouriteActionState,
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: Text(
                "Favourites",
                style: TextStyle(
                    color: Theme.of(context).primaryTextTheme.bodyLarge?.color,
                    fontWeight: FontWeight.bold),
              ),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            body: switch (state.runtimeType) {
              const (FavouritesLoadingState) => const LoadingScreen(),
              const (FavouritesSuccessState) => FavouritesListViewUILoaded(
                  response:
                      (state as FavouritesSuccessState).favouriteCharactersList,
                  bloc: favouritesBloc),
              const (FavouritesSuccessEmptyState) => const FavouritesEmptyUI(),
              const (FavouritesFailureState) => const FavouritesUIFailure(),
              _ => Center(child: Text(state.runtimeType.toString()))
            });
      },
    );
  }
}

class FavouritesUIFailure extends StatelessWidget {
  const FavouritesUIFailure({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color.fromARGB(255, 14, 14, 14),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset("assets/images/exception_image.jpg"),
            const Center(
              child: Column(
                children: [
                  SizedBox(height: 200),
                  Text(
                    "Err! Can't Load Characters ",
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 30,
                      fontFamily: 'Mouldy',
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}

class FavouritesEmptyUI extends StatelessWidget {
  const FavouritesEmptyUI({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color.fromARGB(255, 14, 14, 14),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset("assets/images/empty.png"),
            const Center(
              child: Column(
                children: [
                  SizedBox(height: 200),
                  Text(
                    "First Add Favourites dumdums!",
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 24,
                      fontFamily: 'Mouldy',
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}

class FavouritesListViewUILoaded extends StatelessWidget {
  const FavouritesListViewUILoaded({
    super.key,
    required this.response,
    required this.bloc,
  });

  final FavouritesBloc bloc;
  final List<CharacterModel> response;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: ListView.builder(
        itemCount: response.length,
        itemBuilder: (context, index) {
          final character = response[index];
          return CharacterCard(
            character: character,
            bloc: bloc,
            onLikePressed: () {
              bloc.add(FavouritesCharacterFavouriteClickedEvent(
                  index: index,
                  characterList: response,
                  bloc: context.read<HomeBloc>()));
            },
          );
        },
      ),
    );
  }
}
