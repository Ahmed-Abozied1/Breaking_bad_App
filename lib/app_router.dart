import 'package:flutter/material.dart';

import 'business_logic_layer/cubit/characters_cubit.dart';
import 'constants/strings.dart';
import 'data_layer/repositery/characters_repositery.dart';
import 'data_layer/wep_services/characters_wep_services.dart';
import 'presentation_layer/screens/character_screen.dart';
import 'presentation_layer/screens/characters_details_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data_layer/model/chacracters.dart';

class AppRouter {
  late CharactersRepository charactersRepository;
  late CharactersCubit charactersCubit;
  AppRouter() {
    charactersRepository = CharactersRepository(CharactersWepServices());
    charactersCubit = CharactersCubit(charactersRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charctersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => charactersCubit,
            child: CharacterScreen(),
          ),
        );

      case charctersDetailsScreen:
        final character = settings.arguments as Character;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (BuildContext context) =>
                    CharactersCubit(charactersRepository),
                child: CharacterDatailsScreen(
                  character: character,
                )));
    }
  }
}
