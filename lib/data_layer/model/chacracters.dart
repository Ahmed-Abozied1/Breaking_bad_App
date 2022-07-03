// class Character {
//   late int charId;
//   late String name;
//   late String nickName;
//   late String image;
//   late List<dynamic> jops;
//   late String statuseIfDeadOrAlive;
//   late List<dynamic> appearanceOfSeaseons;
//   late String actorName;
//   late String categoryForTowSeries;
//   late String betterCallSaulAppearance;

//   Character.fromJson(Map<String, dynamic> json) {
//     charId = json["char_id"];
//     name = json["name"];
//     nickName = json["nickname"];
//     image = json["img"];
//     jops = json["occupation"];
//     statuseIfDeadOrAlive = json["status"];
//     appearanceOfSeaseons = json["appearance"];
//     actorName = json["portrayed"];
//     categoryForTowSeries = json["category"];
//     betterCallSaulAppearance = json["better_call_saul_appearance"];
//   }
// }
class Character {
  int? charId;
  String? name;
  String? birthday;
  List<dynamic>? occupation;
  String? image;
  String? status;
  String? nickname;
  List<int>? appearance;
  String? portrayed;
  String? category;
  // List<Null>? betterCallSaulAppearance;
  late List betterCallSaulAppearance;
  Character(
      {this.charId,
      this.name,
      this.birthday,
      this.occupation,
      this.image,
      this.status,
      this.nickname,
      this.appearance,
      this.portrayed,
      this.category,
      required this.betterCallSaulAppearance});

  Character.fromJson(Map<String, dynamic> json) {
    charId = json['char_id'];
    name = json['name'];
    birthday = json['birthday'];
    occupation = json['occupation'].cast<String>();
    image = json['img'];
    status = json['status'];
    nickname = json['nickname'];
    appearance = json['appearance'].cast<int>();
    portrayed = json['portrayed'];
    category = json['category'];
    betterCallSaulAppearance = json["better_call_saul_appearance"];
    // if (json['better_call_saul_appearance'] != null) {
    //   betterCallSaulAppearance = <Null>[];
    //   json['better_call_saul_appearance'].forEach((v) {
    //     betterCallSaulAppearance!.add(new Null.fromJson(v));
    //   });
    // }
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['char_id'] = this.charId;
  //   data['name'] = this.name;
  //   data['birthday'] = this.birthday;
  //   data['occupation'] = this.occupation;
  //   data['img'] = this.image;
  //   data['status'] = this.status;
  //   data['nickname'] = this.nickname;
  //   data['appearance'] = this.appearance;
  //   data['portrayed'] = this.portrayed;
  //   data['category'] = this.category;
  //   // if (this.betterCallSaulAppearance != null) {
  //   //   data['better_call_saul_appearance'] =
  //   //       this.betterCallSaulAppearance!.map((  v) => v.toJson()).toList();
  //   // }
  //   return data;
  // }
}
