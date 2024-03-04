import 'package:dio/dio.dart';
import 'package:pokedex/features/detail/data/dto/pokemon_detail.dto.dart';

class PokemonDetailRepository {
  final _dio = Dio();
  Future<PokemonDetailDTO> getPokemonDetail(String url) async {
    try {
      final response = await _dio.get(url);
      final result = response.data as Map<String, dynamic>;
      return PokemonDetailDTO.fromJson(result);
    } catch (e) {
      throw Exception('Failed to retrieve Pokémon list: $e');
    }
  }
}
