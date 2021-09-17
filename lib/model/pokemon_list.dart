import 'package:pokemon_app/model/pokemon.dart';

class PokemonList {
  final List<Pokemon> pokemons;

  PokemonList({this.pokemons});

  factory PokemonList.fromJson(Map<String, dynamic> json) {
    Iterable pokemons = json['pokemon'];
    List<Pokemon> pokemonsList =
        pokemons.map((poke) => Pokemon.fromJson(poke['pokemon'])).toList();

    return PokemonList(
      pokemons: pokemonsList,
    );
  }
}
