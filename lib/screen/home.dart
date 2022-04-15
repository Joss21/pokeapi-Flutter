import 'package:apipoke/api/poke_api.dart';
import 'package:apipoke/model/summary.dart';
import 'package:apipoke/screen/detail.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<PokemonIndex>? pokemonIndex;

  @override
  void initState() {
    super.initState();
    pokemonIndex = PokemonApi().fetchPokemon();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Pokemon Api'),
            centerTitle: true,
            backgroundColor: Colors.red),
        body: FutureBuilder<PokemonIndex>(
          future: pokemonIndex,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasData) {
                final data = snapshot.data!.pokemonSummary;

                return PokemonListView(
                  data: data,
                );
              } else {
                return const Center(
                  child: Text('No hay datos'),
                );
              }
            }
          },
        ));
  }
}

class PokemonListView extends StatelessWidget {
  final dynamic data;
  const PokemonListView({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    chekPokemon(context, url) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PokemonDetailPage(url: url),
        ),
      );
    }

    return ListView.builder(
        itemCount: data!.length,
        itemBuilder: (context, index) {
          final name = data[index].name;
          return Card(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: ListTile(
                onTap: () {
                  chekPokemon(context, data[index].url);
                },
                title: Center(
                  child: Text(
                    '$name'.toUpperCase(),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
