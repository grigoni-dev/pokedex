import 'package:pokedex/features/detail/data/dto/pokemon_ability.dto.dart';
import 'package:pokedex/features/detail/data/dto/pokemon_type.dto.dart';

class PokemonDetailDTO {
  final int id;
  final String name;
  final String imageUrl;
  final double weight;
  final double height;
  final List<PokemonTypeDTO> types;
  final List<PokemonAbilityDTO> abilities;

  PokemonDetailDTO({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.weight,
    required this.height,
    required this.types,
    required this.abilities,
  });

  factory PokemonDetailDTO.fromJson(Map<String, dynamic> json) {
    final abilities = (json['abilities'] as List<dynamic>)
        .map((ability) => PokemonAbilityDTO.fromJson(ability))
        .toList();

    final types = (json['types'] as List<dynamic>)
        .map((type) => PokemonTypeDTO.fromJson(type))
        .toList();

    return PokemonDetailDTO(
      id: json['id'],
      name: json['name'],
      imageUrl: json['sprites']['other']['official-artwork']['front_default'],
      weight: json['weight'] / 10,
      height: json['height'] / 10,
      types: types,
      abilities: abilities,
    );
  }
}
