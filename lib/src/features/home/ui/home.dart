import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movie_bloc/src/features/common/data/models/character_model.dart';
import 'package:movie_bloc/src/features/common/data/models/response.dart';
import 'package:movie_bloc/src/features/common/network/api_service.dart';
import 'package:movie_bloc/src/features/common/ui/character_card.dart';
import 'package:movie_bloc/src/features/home/bloc/home_bloc.dart';

import '../../common/ui/common_widgets.dart';
import 'home_page_list.dart';

class Home extends StatefulWidget {
  final HomeBloc homeBloc;

  const Home({super.key, required this.homeBloc});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    widget.homeBloc.add(HomeInitEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listenWhen: (previous, current) {
        return current is HomeActionState;
      },
      buildWhen: (previous, current) => current is! HomeActionState,
      bloc: widget.homeBloc,
      listener: (context, state) {
        switch (state) {
          case HomeNavigateToFavouritesPageActionState():
            {
              Navigator.pushNamed(context, '/favourites');
            }

          case HomeFavouritesListChangedState():
            {
              setState(() => {});
            }

          default:
        }
      },

      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: Text(
                "Rick & Morty",
                style: TextStyle(
                    color: Theme.of(context).primaryTextTheme.bodyLarge?.color,
                    fontWeight: FontWeight.bold),
              ),
              backgroundColor: Theme.of(context).primaryColor,
              actions: [
                Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: IconButton(
                        iconSize: 35,
                        onPressed: () {
                          widget.homeBloc.add(HomeFavouriteNavigateEvent());
                        },
                        icon: const Icon(Icons.favorite, color: Colors.white)))
              ],
            ),


            
            body: switch (state.runtimeType) {
              const (LoadingState) => const LoadingScreen(),
              const (SuccessState) => HomeListViewUILoaded(
                  response: (state as SuccessState).charactersList,
                  bloc: widget.homeBloc),
              const (FailureState) => const HomeUIFailure(),
              _ => Center(child: Text(state.runtimeType.toString()))
            });
      },
    );
  }
}


class HomeUIFailure extends StatelessWidget {
  const HomeUIFailure({
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


class HomeListViewUILoaded extends StatelessWidget {
  const HomeListViewUILoaded({
    super.key,
    required this.response,
    required this.bloc,
  });

  final HomeBloc bloc;
  final List<CharacterModel> response;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20.0), 
        child: PagedList(bloc: bloc)
        );
  }
}

