import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/core/presentation/theme/colors.dart';
import 'package:pokedex/features/detail/data/dto/pokemon_detail.dto.dart';
import 'package:pokedex/features/detail/data/providers/providers.dart';
import 'package:pokedex/features/detail/data/repositories/pokemon_detail.repository.dart';

class DetailScreen extends ConsumerWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final url = ref.read(pokemonUrlProvider);
    final pokemonFuture = PokemonDetailRepository().getPokemonDetail(url);

    return FutureBuilder<PokemonDetailDTO>(
      future: pokemonFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          _showSnackBar(context, snapshot.error.toString(), UIColors.error);
        } else if (!snapshot.hasData) {
          _showSnackBar(context, 'No data found', UIColors.warning);
        }

        final pokemon = snapshot.data!;

        return Scaffold(
          appBar: AppBar(
              centerTitle: true,
              title: Image.network(
                  height: 40,
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTUReXAxDs9Jg9-pVEymo7yIDD4BpJ-HnamR8wIP9Ty6w&s'),
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  GoRouter.of(context).pop();
                },
              )),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _showConfirmedPurchaseDialog(context),
            label: const Text('Buy',
                style: TextStyle(color: Colors.white, fontSize: 16)),
            icon: const Icon(Icons.shopping_cart),
            backgroundColor: Theme.of(context).primaryColor,
          ),
          body: Center(
            child: Column(
              children: [
                Image(
                  image: NetworkImage(
                    pokemon.imageUrl,
                  ),
                  width: 250.0,
                  height: 250.0,
                  fit: BoxFit.fill,
                ),
                Stack(
                  children: [
                    Container(
                      height: 65,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          )),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 28, vertical: 4),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 28, vertical: 4),
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
                                              color: Theme.of(context)
                                                  .primaryColorDark),
                                    ),
                                    subtitle: Text(
                                      '${pokemon.height} m',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .primaryColorDark,
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
                                              color: Theme.of(context)
                                                  .primaryColorDark),
                                    ),
                                    subtitle: Text(
                                      '${pokemon.weight} kg',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .primaryColorDark,
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
                                    .copyWith(
                                        color:
                                            Theme.of(context).primaryColorDark),
                              ),
                              subtitle: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    ...pokemon.types
                                        .map((type) => Chip(
                                              backgroundColor: Theme.of(context)
                                                  .primaryColor,
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
                                    .copyWith(
                                        color:
                                            Theme.of(context).primaryColorDark),
                              ),
                              subtitle: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    ...pokemon.abilities
                                        .map((type) => Chip(
                                              backgroundColor: Theme.of(context)
                                                  .primaryColor,
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
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showSnackBar(
      BuildContext context, String message, Color backgroundColor) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor,
        content: Text(message),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {},
        ),
      ),
    );
  }

  Future<void> _showConfirmedPurchaseDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Info'),
          content: const Text("You've buy a Pokémon!"),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                GoRouter.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
