import 'package:flutter/material.dart';
import 'package:pokedex2flutter/common/models/pokemon.dart';
import 'package:pokedex2flutter/features/pokedex/screens/details/container/detail_container.dart';
import 'package:pokedex2flutter/features/pokedex/screens/home/pages/widgets/pokemon_item_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.list, required this.onItemTap})
      : super(key: key);
  final List<Pokemon> list;
  final Function(String, DetailArguments) onItemTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: GridView.count(
          crossAxisCount: 1,
          crossAxisSpacing: 24,
          mainAxisSpacing: 24,
          children: list
              .map(
                (e) => PokemonItemWidget(pokemon: e),
              )
              .toList(),
        ),
      ),
    );
  }
}
