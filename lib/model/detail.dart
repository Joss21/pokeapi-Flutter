import 'dart:convert';

PokemonDetail pokemonDetailFromJson(String str) =>
    PokemonDetail.fromJson(json.decode(str));

String pokemonDetailToJson(PokemonDetail data) => json.encode(data.toJson());

class PokemonDetail {
  PokemonDetail({
    this.name,
    this.weight,
    this.sprites,
    //this.height,
  });

  String? name;
  int? weight;
  //String? height;

  Sprites? sprites;

  factory PokemonDetail.fromJson(Map<String, dynamic> json) => PokemonDetail(
        name: json["name"],
        weight: json["weight"],
        // height: json["height"],
        sprites: Sprites.fromJson(json["sprites"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "weight": weight,
        //"height": height,
        "sprites": sprites!.toJson(),
      };
}

class Sprites {
  Sprites({
    this.backDefault,
    this.frontDefault,
  });

  String? backDefault;
  String? frontDefault;

  factory Sprites.fromJson(Map<String, dynamic> json) => Sprites(
        backDefault: json["back_default"],
        frontDefault: json["front_default"],
      );

  Map<String, dynamic> toJson() => {
        "back_default": backDefault,
        "front_default": frontDefault,
      };
}
