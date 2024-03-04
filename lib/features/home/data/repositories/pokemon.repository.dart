import 'package:dio/dio.dart';
import 'package:pokedex/features/home/data/dto/pokemon.dto.dart';

class PokemonRepository {
  final _dio = Dio();
  Future<List<PokemonDTO>> getAll() async {
    try {
      final response = await _dio
          .get('https://pokeapi.co/api/v2/pokemon?offset=0&limit=500');
      if (response.statusCode != 200) {
        return [];
      }
      if (response.data['results'] == null) {
        return [];
      }

      final results = response.data['results'] as List<dynamic>;
      return results.map((result) => PokemonDTO.fromJson(result)).toList();
    } catch (e) {
      throw Exception('Failed to retrieve Pokémon list: $e');
    }
  }
}
