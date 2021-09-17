import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pokemon_app/model/pokemon_list.dart';

class PokemonController {
  Future getPokemons() async {
    String uri = "https://pokeapi.co/api/v2/type/normal";
    http.Response response = await http.get(Uri.parse(uri));

    if (response.statusCode == 200) {
      print("GOT POKEMONS!!");
      return PokemonList.fromJson(jsonDecode(response.body));
    }
    throw "UNABLE TO GET DATA!";
  }
}
