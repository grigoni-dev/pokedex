class PokemonTypeDTO {
  final int slot;
  final String name;
  final String url;

  PokemonTypeDTO({
    required this.slot,
    required this.name,
    required this.url,
  });

  factory PokemonTypeDTO.fromJson(Map<String, dynamic> json) {
    return PokemonTypeDTO(
      slot: json['slot'],
      name: json['type']['name'],
      url: json['type']['url'],
    );
  }
}
