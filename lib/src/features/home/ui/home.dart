import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_bloc/src/features/common/data/character_model.dart';
import 'package:movie_bloc/src/features/common/network/api_service.dart';
import 'package:movie_bloc/src/features/common/repository/rick_and_morty_repository_impl.dart';
import 'package:movie_bloc/src/features/common/ui/character_card.dart';
import 'package:movie_bloc/src/features/home/bloc/home_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CharacterModel> response = [];
  CharacterModel character = CharacterModel(
      id: 2,
      name: "name",
      status: 'status',
      species: 'species',
      type: 'type',
      gender: 'gender',
      image: 'image',
      url: 'url');
  @override
  void initState() {
    getAllCharacters();
    super.initState();
  }

  final homeBloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(

       listenWhen :(previous, current) {
        return current is HomeActionState;
       },
      // buildWhen: (previous, current) {
        
      // },
      bloc: homeBloc,
      listener: (context, state) {
        switch(state)
        {
          case HomeNavigateToFavouritesPageActionState() :
          {
            Navigator.pushNamed(context, '/favourites');
          }
          case HomeInitial():
          
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
          body: Container(
            padding: const EdgeInsets.all(20.0),
            child: ListView.builder(
              itemCount: response.length,
              itemBuilder: (context, index) {
                final character = response[index];
                return CharacterCard(
                  name: character.name,
                  species: character.species,
                  image: character.image,
                );
              },
            ),
          ),
        );
      },
    );
  }

  void getAllCharacters() async {
    final apiService = ApiService();
    final list =
        await RickAndMortyRepositoryImpl(apiService).getAllCharacters();
    setState(() {
      response = list;
      character = response[5];
    });
  }
}
