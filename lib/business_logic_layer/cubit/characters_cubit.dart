import 'package:bloc/bloc.dart';
import '../../data_layer/repositery/characters_repositery.dart';
import 'package:meta/meta.dart';

import '../../data_layer/model/chacracters.dart';
import '../../data_layer/model/qoutes.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository charactersRepository;
   List<Character> characters =[];
  CharactersCubit(this.charactersRepository) : super(CharactersInitial());



  
  List<Character> getAllCharacters() {
    charactersRepository.getAllCharacters().then((characters) {
      emit(CharactersLoaded(characters));
      this.characters = characters;
    });
    return characters;
  }

  void getQuotes(String charName) {
    charactersRepository.getCharacterQuotes(charName).then((quotes) {
      emit(QuoteLoaded(quotes));
     
    });
   
  }
}
