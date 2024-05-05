import '../data/character_model.dart';

abstract class RickAndMortyRepository {
  Future<List<CharacterModel>> getAllCharacters();

  Future<void> updateCharacterLikedStatus(CharacterModel character);

  Future<List<CharacterModel>> addToFavurites(CharacterModel characterModel);

  Future<List<CharacterModel>> removeFromfavourites(CharacterModel characterModel);

  Future<List<CharacterModel>> getAllFavourites();
}
