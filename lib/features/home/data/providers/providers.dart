import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/features/home/data/dto/pokemon.dto.dart';
import 'package:pokedex/features/home/data/repositories/pokemon.repository.dart';

final allPokemonProvider = FutureProvider<List<PokemonDTO>>(
  (ref) async {
    return await PokemonRepository().getAll();
  },
);

final filteredPokemonProvider = Provider<List<PokemonDTO>>((ref) {
  final allPokemon = ref.watch(allPokemonProvider);
  final searchQuery = ref.watch(searchQueryProvider.notifier).state;

  // Filtra gli elementi in base al testo di ricerca
  return allPokemon.when(
    data: (elements) {
      return elements.where((element) {
        return element.name.toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    },
    loading: () => [],
    error: (_, __) => [],
  );
});

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchQueryIsEmptyProvider =
    Provider<bool>((ref) => ref.watch(searchQueryProvider).isEmpty);
