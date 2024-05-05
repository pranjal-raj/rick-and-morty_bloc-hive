import 'package:movie_bloc/src/features/common/data/character_model.dart';
import 'package:movie_bloc/src/features/common/data/favourited_characters.dart';
import 'package:movie_bloc/src/features/common/network/api_service.dart';
import 'package:movie_bloc/src/features/common/repository/rick_and_morty_repository.dart';

class RickAndMortyRepositoryImpl extends RickAndMortyRepository {
  final ApiService _apiService;
  RickAndMortyRepositoryImpl(this._apiService);

  @override
  Future<List<CharacterModel>> getAllCharacters() async {
    return await _apiService.getAllCharacters();
  }

  @override
  Future<List<CharacterModel>> getAllFavourites() async {
    return Future.value(favourites);
  }

  @override
  Future<void> updateCharacterLikedStatus(CharacterModel character) async {
    final int id = character.id;
    return await character.updateLiked();
  }

  @override
  Future<List<CharacterModel>> addToFavurites(
      CharacterModel characterModel) async {
    favourites.add(characterModel);
    return Future.value(favourites);
  }

  @override
  Future<List<CharacterModel>> removeFromfavourites(CharacterModel characterModel) async {
    favourites.remove(characterModel);
    return Future.value(favourites);
  }
}
