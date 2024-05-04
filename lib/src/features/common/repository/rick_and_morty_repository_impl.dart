import 'package:movie_bloc/src/features/common/data/character_model.dart';
import 'package:movie_bloc/src/features/common/network/api_service.dart';
import 'package:movie_bloc/src/features/common/repository/rick_and_morty_repository.dart';

class RickAndMortyRepositoryImpl extends RickAndMortyRepository 
{
  final ApiService _apiService;
  RickAndMortyRepositoryImpl(this._apiService);

  
  @override
  Future<List<CharacterModel>> getAllCharacters() async{
    return await _apiService.getAllCharacters();
  }
  
} 