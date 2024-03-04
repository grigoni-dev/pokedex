import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/core/presentation/theme/colors.dart';
import 'package:pokedex/features/detail/data/providers/providers.dart';
import 'package:pokedex/features/home/data/dto/pokemon.dto.dart';
import 'package:pokedex/features/home/data/repositories/pokemon.repository.dart';
import 'package:pokedex/features/home/presentation/widget/home_searchbar.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  TextEditingController searchController = TextEditingController();

  late Future<List<PokemonDTO>> allPokemonFuture;
  late List<PokemonDTO> allPokemon;
  List<PokemonDTO> filteredPokemon = [];

  @override
  void initState() {
    allPokemonFuture = PokemonRepository().getAll();
    super.initState();
  }

  void filterSearchResults(String query) {
    setState(() {
      filteredPokemon = allPokemon.where((element) {
        return element.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) {
          return SafeArea(
            child: Column(
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  surfaceTintColor: Colors.transparent,
                  centerTitle: true,
                  title: Image.network(
                      height: 40,
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTUReXAxDs9Jg9-pVEymo7yIDD4BpJ-HnamR8wIP9Ty6w&s'),
                ),
                HomeSearchBar(
                    searchController: searchController,
                    filterSearchResults: filterSearchResults),
                pokemonList(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget pokemonList() {
    return Expanded(
      child: FutureBuilder<List<PokemonDTO>>(
        future: allPokemonFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            _showSnackBar(context, snapshot.error.toString(), UIColors.error);
          } else if (!snapshot.hasData) {
            _showSnackBar(context, 'No data found', UIColors.warning);
          }

          allPokemon = snapshot.data!;
          return Consumer(
            builder: (context, ref, child) {
              filteredPokemon = allPokemon.where((element) {
                return element.name
                    .toLowerCase()
                    .contains(searchController.text.toLowerCase());
              }).toList();
              return ListView.builder(
                itemCount: filteredPokemon.length,
                itemBuilder: (context, index) {
                  final pokemon = filteredPokemon[index];
                  return GestureDetector(
                    onTap: () {
                      ref.watch(pokemonUrlProvider.notifier).state =
                          pokemon.url;
                      GoRouter.of(context).push('/detail');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 28, vertical: 4),
                      padding: const EdgeInsets.all(16),
                      child: Text(pokemon.name.toUpperCase() ?? ""),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
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
}
