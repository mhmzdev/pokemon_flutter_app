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

class Pokemon {
  final String name;
  final String url;

  Pokemon({this.name, this.url});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'],
      url: json['url'],
    );
  }
}
