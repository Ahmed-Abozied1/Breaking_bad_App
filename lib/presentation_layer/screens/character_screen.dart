import 'package:flutter/material.dart';
import '../../business_logic_layer/cubit/characters_cubit.dart';
import '../../constants/my_color.dart';
import '../../constants/strings.dart';
import '../../data_layer/model/chacracters.dart';
import '../widget/character_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

class CharacterScreen extends StatefulWidget {
  const CharacterScreen({Key? key}) : super(key: key);

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  List<Character>? allCharacters;
  List<Character>? searchedForCharacters;
  bool _isSearching = false;
  final _searchedController = TextEditingController();

  Widget _buildSearchField() {
    return TextField(
      controller: _searchedController,
      cursorColor: MyColors.myGrey,
      decoration: const InputDecoration(
          hintText: "find a character",
          border: InputBorder.none,
          hintStyle: TextStyle(color: MyColors.myGrey, fontSize: 18)),
      style: const TextStyle(color: MyColors.myGrey, fontSize: 18),
      onChanged: (searchedCharacter) {
        addSrearchedForItemToSearchedList(searchedCharacter);
      },
    );
  }

  Widget _buildAppBarTitle() {
    return const Text(
      "Characters",
      style: TextStyle(color: MyColors.myGrey),
    );
  }

  void addSrearchedForItemToSearchedList(searchedCharacter) {
    searchedForCharacters = allCharacters!
        .where((character) =>
            character.name!.toLowerCase().startsWith(searchedCharacter))
        .toList();
    setState(() {});
  }

  List<Widget> _buildAppBarAction() {
    if (_isSearching) {
      return [
        IconButton(
          onPressed: () {
            _clearSearch();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.clear),
          color: MyColors.myGrey,
        )
      ];
    } else {
      return [
        IconButton(
          onPressed: _startSearch,
          icon: const Icon(Icons.search),
          color: MyColors.myGrey,
        )
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearch));
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearch() {
    _clearSearch();
    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchedController.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context)
        .getAllCharacters(); //   بيطب من البلوك يقوله  ادينى الداتا ui
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
        builder: (context, state) {
      if (state is CharactersLoaded) {
        allCharacters = (state).characters;
        return buildLoadedWidgets();
      } else {
        return showprogressIndicator();
      }
    });
  }

  Widget showprogressIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.black,
      ),
    );
  }

  Widget buildLoadedWidgets() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.myGrey,
        child: Column(
          children: [
            buildCharactersList(),
          ],
        ),
      ),
    );
  }

  Widget buildCharactersList() {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 3,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: _searchedController.text.isEmpty
            ? allCharacters!.length
            : searchedForCharacters!.length,
        itemBuilder: (context, index) {
          return CharacterItem(
              character: _searchedController.text.isEmpty
                  ? allCharacters![index]
                  : searchedForCharacters![index]);
        });
  }

  Widget _buildNoInternet() {
    return Center(
      child: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            //   mainAxisAlignment: MainAxisAlignment.centr,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const SizedBox(
                height: 15.0,
              ),
              const Text(
                "No internet,Please check your Connection...",
                style: TextStyle(fontSize: 20, color: MyColors.myGrey),
              ),
              Image.asset("asset/images/no_internet.png")
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.myYello,
          title: _isSearching ? _buildSearchField() : _buildAppBarTitle(),
          actions: _buildAppBarAction(),
          leading: _isSearching
              ? const BackButton(
                  color: MyColors.myGrey,
                )
              : Container(),
        ),
        body: OfflineBuilder(
          connectivityBuilder: (
            BuildContext context,
            ConnectivityResult connectivity,
            Widget child,
          ) {
            final bool connected = connectivity != ConnectivityResult.none;

            if (connected) {
              return buildBlocWidget();
            } else {
              return _buildNoInternet();
            }
          },
          child: showprogressIndicator(),
        ));
  }
}
