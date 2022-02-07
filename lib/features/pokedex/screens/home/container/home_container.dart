import 'package:flutter/material.dart';
import 'package:pokedex2flutter/common/error/failure.dart';
import 'package:pokedex2flutter/common/models/pokemon.dart';
import 'package:pokedex2flutter/common/repository/pokemon_repository.dart';
import 'package:pokedex2flutter/features/pokedex/screens/details/container/detail_container.dart';
import 'package:pokedex2flutter/features/pokedex/screens/home/pages/home_error.dart';
import 'package:pokedex2flutter/features/pokedex/screens/home/pages/home_loading.dart';
import 'package:pokedex2flutter/features/pokedex/screens/home/pages/home_page.dart';

class HomeContainer extends StatelessWidget {
  const HomeContainer({
    Key? key,
    required this.repository,
    required this.onItemTap,
  }) : super(key: key);
  final IPokemonRepository repository;
  final Function(String, DetailArguments) onItemTap;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Pokemon>>(
        future: repository.getAllPokemons(),
        builder: (context, snaphot) {
          if (snaphot.connectionState == ConnectionState.waiting) {
            return const HomeLoading();
          }

          if (snaphot.connectionState == ConnectionState.done &&
              snaphot.hasData) {
            return HomePage(
              list: snaphot.data!,
              onItemTap: onItemTap,
            );
          }
          if (snaphot.hasError) {
            return HomeError(
              error: (snaphot.error as Failure).message!,
            );
          }
          return Container();
        });
  }
}
