import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeSearchBar extends ConsumerWidget {
  final TextEditingController searchController;
  final Function(String value) filterSearchResults;

  const HomeSearchBar(
      {super.key,
      required this.searchController,
      required this.filterSearchResults});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(28),
      child: TextField(
        controller: searchController,
        onChanged: (value) {
          filterSearchResults(value);
        },
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: Colors.white),
        decoration: InputDecoration(
          fillColor: Theme.of(context).primaryColor,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide.none,
          ),
          hintText: 'Cerca Pokémon...',
          hintStyle: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.white),
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
