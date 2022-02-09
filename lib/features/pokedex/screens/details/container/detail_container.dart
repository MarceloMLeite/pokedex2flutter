import 'package:flutter/material.dart';
import 'package:pokedex2flutter/common/error/failure.dart';
import 'package:pokedex2flutter/common/models/pokemon.dart';
import 'package:pokedex2flutter/common/repository/pokemon_repository.dart';
import 'package:pokedex2flutter/common/widgets/po_error.dart';
import 'package:pokedex2flutter/common/widgets/po_loading.dart';
import 'package:pokedex2flutter/features/pokedex/screens/details/pages/detail_page.dart';

class DetailArguments {
  DetailArguments({required this.pokemon});
  final Pokemon pokemon;
}

class DetailContainer extends StatelessWidget {
  const DetailContainer(
      {Key? key, required this.repository, required this.arguments})
      : super(key: key);
  final IPokemonRepository repository;
  final DetailArguments arguments;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Pokemon>>(
        future: repository.getAllPokemons(),
        builder: (context, snaphot) {
          if (snaphot.connectionState == ConnectionState.waiting) {
            return const PoLoading();
          }

          if (snaphot.connectionState == ConnectionState.done &&
              snaphot.hasData) {
            return DetailPage(pokemon: arguments.pokemon, list: snaphot.data!);
          }

          if (snaphot.hasError) {
            return PoError(
              error: (snaphot.error as Failure).message!,
            );
          }
          return Container();
        });
  }
}
