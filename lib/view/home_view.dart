import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokemon_app/auth/auth.dart';
import 'package:pokemon_app/constants.dart';
import 'package:pokemon_app/controller/pokemon_controller.dart';
import 'package:pokemon_app/model/pokemon.dart';
import 'package:pokemon_app/widgets/custom_loader.dart';
import 'package:pokemon_app/widgets/pokemon_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  List<String> _localList = [];
  List<Pokemon> pokemons = [];
  List favsPokemons = [];

  final _auth = Auth();

  void _loadData() async {
    PokemonList data = await PokemonController().getPokemons();

    setState(() {
      pokemons = List.from(data.pokemons);
    });

    setState(() {
      _checkFavs();
    });
  }

  void _checkFavs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _localList = prefs.getStringList(_firebaseAuth.currentUser.uid);

    if (_localList == null) {
      return;
    }

    for (int i = 0; i < pokemons.length; i++) {
      if (i != _localList.length) {
        if (pokemons[i].name == _localList[i]) {
          print("MATCHED!! ${_localList[i]}");
          setState(() {
            favsPokemons.add(pokemons[i].name);
          });
        }
      } else {
        break;
      }
    }
  }

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) =>
            <Widget>[
          SliverAppBar(
            leading: BackButton(
              onPressed: () async {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: const Duration(seconds: 2),
                    backgroundColor: kPrimaryColor,
                    content: Row(
                      children: [
                        const Icon(Icons.person, color: Colors.white),
                        const SizedBox(width: 8.0),
                        const Text("Signed out! Good bye :)"),
                      ],
                    ),
                  ),
                );
                await _auth.signOut(context);
              },
            ),
            pinned: true,
            expandedHeight: 180.0,
            actions: [
              IconButton(
                onPressed: () async {
                  var value = await Navigator.pushNamed(context, '/favorite');
                  if (value) {
                    setState(() {
                      pokemons.length = 0;
                      _loadData();
                    });
                  }
                },
                icon: Icon(Icons.favorite_border),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                "Pokemons Available!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 19.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Center(
                child: SvgPicture.asset(
                  'assets/pokeball.svg',
                  height: 70.0,
                ),
              ),
            ),
          ),
        ],
        body: pokemons.length == 0
            ? Center(
                child: CustomLoader(),
              )
            : ListView(
                children: List.generate(
                  pokemons.length,
                  (index) => PokemonCard(
                    name: pokemons[index].name,
                    isFavt: favsPokemons.contains(pokemons[index].name),
                  ),
                ),
              ),
      ),
    );
  }
}
