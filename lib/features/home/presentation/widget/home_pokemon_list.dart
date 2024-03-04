// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:pokedex/features/detail/data/providers/providers.dart';
// import 'package:pokedex/features/home/data/dto/pokemon.dto.dart';
// import 'package:pokedex/features/home/data/providers/providers.dart';
//
// class HomePokemonList extends ConsumerStatefulWidget {
//   const HomePokemonList({super.key});
//
//   @override
//   ConsumerState createState() => _HomePokemonListState();
// }
//
// class _HomePokemonListState extends ConsumerState<HomePokemonList> {
//   TextEditingController searchController = TextEditingController();
//
//   late List<PokemonDTO> allPokemon;
//   List<PokemonDTO> filteredPokemon = [];
//
//   @override
//   void initState() {
//     final allPokemonFuture = ref.watch(allPokemonProvider);
//     allPokemonFuture.whenData((value) {
//       allPokemon = filteredPokemon = value;
//     });
//     super.initState();
//   }
//
//   void filterSearchResults(String query) {
//     setState(() {
//       filteredPokemon = allPokemon.where((element) {
//         return element.name.toLowerCase().contains(query.toLowerCase());
//       }).toList();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         header(),
//         searchBar(),
//         pokemonList(),
//       ],
//     );
//   }
//
//   Widget header() => Container(
//         padding: const EdgeInsets.all(16),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               'Pokédex',
//               style: Theme.of(context).textTheme.titleLarge,
//             ),
//           ],
//         ),
//       );
//   Widget pokemonList() => Expanded(
//         child: filteredPokemon.isEmpty
//             ? const Center(
//                 child: CircularProgressIndicator(),
//               )
//             : ListView.builder(
//                 itemCount: filteredPokemon.length,
//                 itemBuilder: (context, index) {
//                   final item = filteredPokemon[index];
//                   return GestureDetector(
//                     onTap: () {
//                       ref.watch(pokemonUrlProvider.notifier).state = item.url;
//                       GoRouter.of(context).push('/detail');
//                     },
//                     child: Card(
//                       elevation: 4,
//                       margin: const EdgeInsets.symmetric(
//                           horizontal: 28, vertical: 4),
//                       child: Container(
//                           padding: const EdgeInsets.all(16),
//                           child: Text(item.name.toUpperCase() ?? "")),
//                     ),
//                   );
//                 },
//               ),
//       );
//   Widget searchBar() => Padding(
//         padding: const EdgeInsets.all(28),
//         child: TextField(
//           controller: searchController,
//           onChanged: (value) {
//             filterSearchResults(value);
//           },
//           style: Theme.of(context).textTheme.bodyMedium,
//           decoration: InputDecoration(
//             fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
//             filled: true,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(16.0),
//               borderSide: BorderSide.none,
//             ),
//             hintText: 'Cerca Pokémon...',
//             prefixIcon: const Icon(Icons.search),
//             suffixIcon: Consumer(
//               builder: (context, ref, _) {
//                 final isEmpty = ref.watch(searchQueryIsEmptyProvider);
//                 return isEmpty
//                     ? const SizedBox.shrink()
//                     : IconButton(
//                         icon: const Icon(Icons.close),
//                         onPressed: () {
//                           searchController.clear();
//                         },
//                       );
//               },
//             ),
//           ),
//         ),
//       );
// }
