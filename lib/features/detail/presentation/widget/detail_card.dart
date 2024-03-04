import 'package:flutter/material.dart';
import 'package:pokedex/features/detail/data/dto/pokemon_detail.dto.dart';

class DetailCard extends StatelessWidget {
  final PokemonDetailDTO pokemon;
  const DetailCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 65,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              )),
          margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 4),
        ),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 4),
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  pokemon.name.toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: ListTile(
                        title: Text(
                          'Height',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: Theme.of(context).primaryColorDark),
                        ),
                        subtitle: Text(
                          '${pokemon.height} m',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: Theme.of(context).primaryColorDark,
                                  fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: ListTile(
                        title: Text(
                          'Weight',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: Theme.of(context).primaryColorDark),
                        ),
                        subtitle: Text(
                          '${pokemon.weight} kg',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: Theme.of(context).primaryColorDark,
                                  fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                ListTile(
                  title: Text(
                    'Types',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Theme.of(context).primaryColorDark),
                  ),
                  subtitle: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ...pokemon.types
                            .map((type) => Chip(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  label: Text(
                                    type.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: Colors.white,
                                        ),
                                  ),
                                ))
                            .toList(),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Abilities',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Theme.of(context).primaryColorDark),
                  ),
                  subtitle: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ...pokemon.abilities
                            .map((type) => Chip(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  label: Text(
                                    type.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: Colors.white,
                                        ),
                                  ),
                                ))
                            .toList(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
