/*
*
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/features/detail/data/dto/pokemon_detail.dto.dart';
import 'package:pokedex/features/detail/data/repositories/pokemon_detail.repository.dart';
import 'package:pokedex/features/home/presentation/screen/home_screen_bkp.dart';

class DetailScreenBkp extends ConsumerStatefulWidget {
  static const String routeName = '/detail';

  const DetailScreenBkp({super.key});

  @override
  ConsumerState createState() => _DetailScreenBkpState();
}

class _DetailScreenBkpState extends ConsumerState<DetailScreenBkp> {
  late PokemonDetailDTO pokemon;
  late PokemnonDetailRepository pokemonDetailRepository;

  @override
  void initState() {
    //final pokemonUrl = ref.watch(pokemonUrlProvider.notifier).state;
    fetchData(
        PokemnonDetailRepository(), 'https://pokeapi.co/api/v2/pokemon/1/');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Pokemon'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              //GoRouter.of(context).go(HomeScreen.routeName);
            },
          )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
        },
        label: const Text('Buy',
            style: TextStyle(color: Colors.white, fontSize: 16)),
        icon: const Icon(Icons.shopping_cart),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Consumer(builder: (context, watch, child) {
        final pokemonUrl = ref.watch(pokemonUrlProvider.notifier).state;
        return Column(
          children: [
            Image.network(
              pokemon.imageUrl,
              width: 250.0,
              height: 250.0,
              fit: BoxFit.fill,
            ),
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 10.0),
                    child: Text(
                      pokemon.name.toUpperCase(),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          Text(
                            'Types',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(width: 10.0),
                          ...pokemon.types
                              .map((type) => Chip(
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                    label: Text(
                                      type.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            color: Colors.white,
                                          ),
                                    ),
                                  ))
                              .toList()
                        ],
                      )),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          Text(
                            'Abilities',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(width: 10.0),
                          ...pokemon.abilities
                              .map((type) => Chip(
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                    label: Text(
                                      type.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            color: Colors.white,
                                          ),
                                    ),
                                  ))
                              .toList()
                        ],
                      )),
                  const SizedBox(
                    height: 30.0,
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  fetchData(PokemnonDetailRepository pokemonDetailRepository, String url) {
    pokemonDetailRepository.getPokemonDetail(url).then((value) {
      setState(() {
        pokemon = value;
      });
    });
  }
}

*
*
* */
