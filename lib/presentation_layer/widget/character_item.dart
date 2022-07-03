import 'package:flutter/material.dart';
import '../../constants/my_color.dart';
import '../../constants/strings.dart';
import '../../data_layer/model/chacracters.dart';

class CharacterItem extends StatelessWidget {
  final Character character;
  const CharacterItem({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: const EdgeInsetsDirectional.all(5),
      decoration: BoxDecoration(
        color: MyColors.myWhite,
        borderRadius: BorderRadius.circular(9),
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, charctersDetailsScreen,
            arguments: character),
        child: GridTile(
          child: Hero(
            //tag: character.charId!.toInt(),
            tag: 1,
            child: Container(
                color: MyColors.myWhite,
                child: character.image!.isNotEmpty
                    ? FadeInImage.assetNetwork(
                        width: double.infinity,
                        height: double.infinity,
                        placeholder: 'asset/images/loading.gif',
                        image: character.image.toString(),
                        fit: BoxFit.cover,
                      )
                    : Image.asset("asset/images/placholder.jpg")),
          ),
          footer: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: Colors.black54,
            //  alignment: Alignment.topCenter,
            child: Text(
              "${character.name}",
              style: const TextStyle(
                height: 1.5,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: MyColors.myWhite,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
