import 'package:apipoke/api/poke_api.dart';
import 'package:apipoke/extensions/ext_cap.dart';
import 'package:apipoke/model/detail.dart';
import 'package:flutter/material.dart';

class PokemonDetailPage extends StatefulWidget {
  final String url;
  const PokemonDetailPage({Key? key, required this.url}) : super(key: key);

  @override
  _PokemonDetailState createState() => _PokemonDetailState();
}

class _PokemonDetailState extends State<PokemonDetailPage> {
  Future<PokemonDetail>? pokemonIndex;

  @override
  void initState() {
    super.initState();
    pokemonIndex = PokemonApi().fetchDetailPokemon(widget.url);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PokemonDetail>(
      future: pokemonIndex,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          if (snapshot.hasData) {
            // data
            final name = snapshot.data!.name;
            final weight = snapshot.data!.weight;
            //final height = snapshot.data!.height;
            final gambar2 = snapshot.data!.sprites!.backDefault;
            final gambar1 = snapshot.data!.sprites!.frontDefault;
            return Scaffold(
              appBar: AppBar(
                  title: Text('Pokemon ' + '$name'.capitalize()),
                  backgroundColor: Colors.red),
              body: Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Name : ' + '$name'.capitalize(),
                      style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                    Image.network(
                      '$gambar1',
                      width: 150,
                      height: 150,
                    ),
                    Image.network(
                      '$gambar2',
                      width: 150,
                      height: 150,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Weight : $weight kg',
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                    /*  Text(
                      'Height : $height m',
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ), */
                  ],
                ),
              ),
            );
          } else {
            // eror
            return const Scaffold(
              body: Center(
                child: Text('No hay informacion'),
              ),
            );
          }
        }
      },
    );
  }
}
