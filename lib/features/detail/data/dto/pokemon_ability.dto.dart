class PokemonAbilityDTO {
  final bool isHidden;
  final int slot;
  final String name;
  final String url;

  PokemonAbilityDTO({
    required this.isHidden,
    required this.slot,
    required this.name,
    required this.url,
  });

  factory PokemonAbilityDTO.fromJson(Map<String, dynamic> json) {
    return PokemonAbilityDTO(
      isHidden: json['is_hidden'],
      slot: json['slot'],
      name: json['ability']['name'],
      url: json['ability']['url'],
    );
  }
}
