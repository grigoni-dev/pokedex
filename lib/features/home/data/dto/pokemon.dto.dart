class PokemonDTO {
  final String name;
  final String url;

  PokemonDTO({required this.name, required this.url});

  factory PokemonDTO.fromJson(Map<String, dynamic> json) {
    return PokemonDTO(
      name: json['name'],
      url: json['url'],
    );
  }
}
