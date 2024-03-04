import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/core/presentation/theme/colors.dart';
import 'package:pokedex/features/detail/data/dto/pokemon_detail.dto.dart';
import 'package:pokedex/features/detail/data/providers/providers.dart';
import 'package:pokedex/features/detail/data/repositories/pokemon_detail.repository.dart';
import 'package:pokedex/features/detail/presentation/widget/detail_card.dart';

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
                DetailCard(pokemon: pokemon),
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
