import 'package:flutter/material.dart';
import 'package:pokedex/features/home/domain/models/pokemon.model.dart';

class PokemonCard extends StatelessWidget {
  final PokemonModel pokemon;
  final VoidCallback onPressed;

  const PokemonCard({
    super.key,
    required this.pokemon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onPressed,
        child: Column(
          children: [
            Text(pokemon.name),
          ],
        ),
      ),
    );
  }
}
