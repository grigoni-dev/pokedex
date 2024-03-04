/*
*
* import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/features/detail/presentation/screen/detail_screen.dart';
import 'package:pokedex/features/home/data/dto/pokemon.dto.dart';
import 'package:pokedex/features/home/data/repositories/pokemon.repository.dart';

final pokemonUrlProvider = StateProvider<String>((ref) => '');

class HomeScreenBkp extends ConsumerStatefulWidget {
  static const String routeName = '/';

  const HomeScreenBkp({super.key});

  @override
  ConsumerState createState() => _HomeScreenBkpState();
}

class _HomeScreenBkpState extends ConsumerState<HomeScreenBkp> {
  late Future<List<PokemonDTO>> futureItems;
  late List<PokemonDTO> items;
  late List<PokemonDTO> filteredItems;
  String searchBarFilter = '';

  @override
  void initState() {
    futureItems = PokemonRepository().getAll();
    super.initState();
  }

  void filterItems(String query) {
    setState(() {
      filteredItems = items
          .where(
            (item) => item.name.toLowerCase().contains(
                  query.toLowerCase(),
                ),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, watch, child) {
          return SafeArea(
            child: Column(
              children: [
                header(),
                searchBar(),
                Expanded(
                  child: buildItemList(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  header() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Pokédex',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }

  Widget searchBar() {
    return Padding(
      padding: const EdgeInsets.all(28),
      child: TextField(
        onChanged: (value) {
          setState(() {
            searchBarFilter = value
                .toLowerCase(); // Converte la ricerca in minuscolo per una corrispondenza senza distinzioni tra maiuscole e minuscole
          });
        },
        style: Theme.of(context).textTheme.bodyMedium,
        decoration: InputDecoration(
          fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide.none,
          ),
          hintText: 'Cerca Pokémon...',
          prefixIcon: const Icon(Icons.search),
        ),
      ),
    );
  }

  FutureBuilder buildItemList() {
    return FutureBuilder(
      future: futureItems,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data.isEmpty) {
          return const Center(child: Text('Nessun dato disponibile'));
        } else {
          items = snapshot.data as List<PokemonDTO>;
          return _buildList(items, searchBarFilter);
        }
      },
    );
  }

  Widget _buildList(List<PokemonDTO> dataList, String searchBarFilter) {
    return ListView.builder(
      itemCount: dataList.length,
      itemBuilder: (context, index) {
        final item = dataList[index];
        if (item.name.toLowerCase().contains(searchBarFilter.toLowerCase())) {
          return GestureDetector(
            onTap: () {
              ref.watch(pokemonUrlProvider.notifier).state = item.url;
              GoRouter.of(context).go(DetailScreen.routeName);
            },
            child: Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 4),
              child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Text(item.name.toUpperCase() ?? "")),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}

* */
