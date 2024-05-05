import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_bloc/src/features/common/data/character_model.dart';
import 'package:movie_bloc/src/features/common/ui/character_card.dart';
import 'package:movie_bloc/src/features/home/bloc/home_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final homeBloc = HomeBloc();

  @override
  void initState() {
    homeBloc.add(HomeInitEvent());
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(

       listenWhen :(previous, current) {
        return current is HomeActionState;
       },
       buildWhen: (previous, current) => current is !HomeActionState,
      bloc: homeBloc,
      listener: (context, state) {
        switch(state)
        {
          case HomeNavigateToFavouritesPageActionState() :
          {
            Navigator.pushNamed(context, '/favourites');
          } 
 
          default:
          print("Default");
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
                      onPressed: () {
                        homeBloc.add(HomeFavouriteNavigateEvent());
                      },
                      icon:
                          const Icon(Icons.favorite, color: Colors.redAccent)))
            ],
          ),
          body: 
          switch(state.runtimeType)
          {
            const (LoadingState)=>
            const Center(
             child : CircularProgressIndicator(color: Colors.black,),
            ),

            const (SuccessState)=>
            HomeListViewUILoaded(response: (state as SuccessState).charactersList,  bloc: homeBloc ),

            const (HomeCharacterListUpdated) =>
             HomeListViewUILoaded(
                  response: (state as HomeCharacterListUpdated).charactersList,
                  bloc: homeBloc),

            const (FailureState)=>
            const HomeUIFailure(),

          _=>
          Center(child: Text(state.runtimeType.toString()))
          }
        );
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
        color: Color.fromARGB(255, 14, 14, 14),
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
    required this.response, required this.bloc,
  });

  final HomeBloc bloc;
  final List<CharacterModel> response;

  @override
  Widget build(BuildContext context) {
    return Container(
    padding: const EdgeInsets.all(20.0),
    child:   
     ListView.builder(
      itemCount: response.length,
      itemBuilder: (context, index) {
        final character = response[index];
        return CharacterCard(
          character: character,
          bloc: bloc,
          onPressed: (){
            print(character.name);
            bloc.add(HomeCharacterFavouriteClickedEvent(characterList: response, index: index));
          },
        );
      },
    ),
              );
  }
}
