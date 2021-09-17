import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_app/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteView extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => FavoriteView());
  }

  @override
  _FavoriteViewState createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  List<String> _favt = [];

  // getting the favs from Local storage via Shared Preferences
  void _getPokemons() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List _local = prefs.getStringList(FirebaseAuth.instance.currentUser.uid);

    if (_local != null) {
      setState(() {
        _favt = List.from(_local);
      });
    }
  }

  @override
  void initState() {
    _getPokemons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => Navigator.of(context).pop(true),
        ),
        title: Text("Favorites Pokemons"),
      ),
      body: _favt.length == 0
          ? Center(
              child: const Text("No Favorites Found!"),
            )
          : ListView(
              padding: const EdgeInsets.all(8.0),
              children: _favt
                  .map(
                    (pokemon) => Card(
                      child: ListTile(
                        title: Text(pokemon.toString().toUpperCase()),
                        trailing: InkWell(
                          onTap: () => _removeFav(pokemon),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Icon(
                              Icons.favorite,
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
    );
  }

  // removing the favs from Local Storage + the List
  void _removeFav(String pokemon) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _favt.remove(pokemon);
    });

    prefs.setStringList(FirebaseAuth.instance.currentUser.uid,
        _favt); // override the local List

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
          Text("${pokemon.toUpperCase()} Removed!"),
        ],
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
