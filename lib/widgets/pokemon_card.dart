import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_app/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PokemonCard extends StatefulWidget {
  final bool isFavt;
  final String name;

  const PokemonCard({Key key, this.isFavt, this.name}) : super(key: key);

  @override
  _PokemonCardState createState() => _PokemonCardState();
}

class _PokemonCardState extends State<PokemonCard> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool _isFav = false;

  @override
  void initState() {
    _isFav = widget.isFavt;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(widget.name.toUpperCase()),
        trailing: InkWell(
          onTap: () => _isFav
              ? _removeFavorite(
                  widget.name.toString().toUpperCase(),
                )
              : _addFavorite(
                  widget.name.toString().toUpperCase(),
                ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Icon(
              _isFav ? Icons.favorite : Icons.favorite_border,
              size: 22.0,
              color: kPrimaryColor,
            ),
          ),
        ),
      ),
    );
  }

  void _addFavorite(String pokemonName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      _isFav = true;
    });

    // first get the list of favorites
    List<String> favs = prefs.getStringList(_firebaseAuth.currentUser.uid);

    if (favs == null) {
      favs = [];
    }

    // add the pokemon to the list
    favs.add(pokemonName.toLowerCase());

    // store the list back to sharedPrefs
    prefs.setStringList(_firebaseAuth.currentUser.uid, favs);

    print(prefs.getStringList(_firebaseAuth.currentUser.uid)); // check the list

    // show snackbar
    var snackBar = SnackBar(
      backgroundColor: Colors.red[800],
      duration: Duration(seconds: 2),
      content: Row(
        children: [
          const Icon(
            Icons.favorite,
            color: Colors.white,
            size: 22.0,
          ),
          const SizedBox(width: 8.0),
          Text("${pokemonName.toUpperCase()} Added!"),
        ],
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _removeFavorite(String pokemonName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      _isFav = false;
    });

    // first get the list of favorites
    List<String> favs = prefs.getStringList(_firebaseAuth.currentUser.uid);

    // add the pokemon to the list
    favs.remove(pokemonName.toLowerCase());

    // store the list back to sharedPrefs
    prefs.setStringList(_firebaseAuth.currentUser.uid, favs);

    print(prefs.getStringList(_firebaseAuth.currentUser.uid)); // check the list

    // show snackbar
    var snackBar = SnackBar(
      backgroundColor: kPrimaryColor,
      duration: Duration(seconds: 2),
      content: Row(
        children: [
          const Icon(
            Icons.delete,
            color: Colors.white,
            size: 22.0,
          ),
          const SizedBox(width: 8.0),
          Text("${pokemonName.toUpperCase()} Removed!"),
        ],
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
