import '../data/character_model.dart';

abstract class RickAndMortyRepository {

  Future<List<CharacterModel>> getAllCharacters();
}