import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/features/detail/data/dto/pokemon_detail.dto.dart';
import 'package:pokedex/features/detail/data/repositories/pokemon_detail.repository.dart';

final pokemonUrlProvider = StateProvider<String>((ref) => '');

final pokemonDetailProvider = FutureProvider<PokemonDetailDTO>(
  (ref) async {
    final url = ref.read(pokemonUrlProvider);
    return await PokemonDetailRepository().getPokemonDetail(url);
  },
);
