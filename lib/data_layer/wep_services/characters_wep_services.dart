import 'package:dio/dio.dart';
import '../../constants/strings.dart';

class CharactersWepServices {
  late Dio dio;
  
  CharactersWepServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000, //60 second
      receiveTimeout: 20 * 1000,
    );
    dio = Dio(options);
   }

  Future<List<dynamic>> getAllCharacters() async {
    try {
      Response response = await dio.get("characters");

     // print(response.data.toString());
      return response.data;
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return [];
    }
  }
  
   Future<List<dynamic>> getCharacterQuotes(String chareName) async {
    try {
      Response response = await dio.get("quote",queryParameters:{"author" :chareName} );

     // print(response.data.toString());
      return response.data;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
