import '../model/qoutes.dart';
import '../wep_services/characters_wep_services.dart';

import '../model/chacracters.dart';

class CharactersRepository {
  final CharactersWepServices charactersWepServices;
  CharactersRepository(
    this.charactersWepServices,
  );

  
  Future<List<Character>> getAllCharacters() async {
    final characters = await charactersWepServices.getAllCharacters();
    return characters
        .map((character) => Character.fromJson(character))
        .toList();
  }

  Future<List<Quote>> getCharacterQuotes(String charName) async {
    final quote = await charactersWepServices.getCharacterQuotes(charName);
    return quote.map((charQuote) => Quote.fromJson(charQuote)).toList();
  }
}
