import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import '../../business_logic_layer/cubit/characters_cubit.dart';
import '../../constants/my_color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data_layer/model/chacracters.dart';

class CharacterDatailsScreen extends StatelessWidget {
  final Character character;

  const CharacterDatailsScreen({Key? key, required this.character})
      : super(key: key);
  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          character.nickname.toString(),
          style: const TextStyle(color: MyColors.myWhite),
        ),
        background: Hero(
            tag: 1,
            //   tag: character.charId!.toInt(),
            child: Image.network(
              character.image.toString(),
              fit: BoxFit.cover,
            )),
      ),
    );
  }

  Widget _characterInfo(String title, String value) {
    return RichText(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(children: [
          TextSpan(
              text: title,
              style: const TextStyle(
                color: MyColors.myWhite,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              )),
          TextSpan(
              text: value,
              style: const TextStyle(
                color: MyColors.myWhite,
                fontSize: 16,
              ))
        ]));
  }

  Widget _buildDivider(double endIndent) {
    return Divider(
      color: MyColors.myYello,
      height: 30,
      endIndent: endIndent,
      thickness: 2,
    );
  }

  Widget checkIfQuotesAreLoaded(CharactersState state) {
    if (state is QuoteLoaded) {
      return displayRandomQuoteOrEmptySpace(state);
    } else
      return showProgtssIndicator();
  }

  Widget displayRandomQuoteOrEmptySpace(State) {
    var quotesList = (State).quotes;
    if (quotesList.length != 0) {
      int randomQuoteIndex = Random().nextInt(quotesList.length - 1);
      return Center(
        child: DefaultTextStyle(
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 20,
                color: MyColors.myWhite,
                shadows: [
                  Shadow(
                    blurRadius: 9,
                    color: MyColors.myYello,
                    offset: Offset(0, 0),
                  )
                ]),
            child: AnimatedTextKit(repeatForever: true,
            
             animatedTexts: [
              FlickerAnimatedText(quotesList[randomQuoteIndex].quote),
            ])),
      );
    } else {
      return Container();
    }
  }

  Widget showProgtssIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: MyColors.myYello,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharactersCubit>(context)
        .getQuotes(character.name.toString());
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              margin: const EdgeInsets.fromLTRB(13, 13, 13, 0),
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _characterInfo("Jop : ", character.occupation!.join(" / ")),
                  _buildDivider(285),
                  _characterInfo(
                      "Appeared in : ", character.category.toString()),
                  _buildDivider(220),
                  _characterInfo(
                      "seasons : ", character.appearance!.join(" / ")),
                  _buildDivider(240),
                  _characterInfo("Status : ", character.status.toString()),
                  _buildDivider(260),
                  character.betterCallSaulAppearance.isEmpty
                      ? Container()
                      : _characterInfo("Better Call Saul Seasons : ",
                          character.betterCallSaulAppearance.toString()),
                  character.betterCallSaulAppearance.isEmpty
                      ? Container()
                      : _buildDivider(120),
                  _characterInfo(
                      "Actor / Actress : ", character.portrayed.toString()),
                  _buildDivider(260),
                  const SizedBox(
                    height: 20.0,
                  ),
                  BlocBuilder<CharactersCubit, CharactersState>(
                      builder: (context, state) {
                    return checkIfQuotesAreLoaded(state);
                  })
                ],
              ),
            ),
          const  SizedBox(
              height: 400,
            )
          ]))
        ],
      ),
    );
  }
}
