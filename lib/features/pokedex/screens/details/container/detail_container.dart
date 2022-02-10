import 'package:flutter/material.dart';
import 'package:pokedex2flutter/common/error/failure.dart';
import 'package:pokedex2flutter/common/models/pokemon.dart';
import 'package:pokedex2flutter/common/repository/pokemon_repository.dart';
import 'package:pokedex2flutter/common/widgets/po_error.dart';
import 'package:pokedex2flutter/common/widgets/po_loading.dart';
import 'package:pokedex2flutter/features/pokedex/screens/details/pages/detail_page.dart';

class DetailArguments {
  DetailArguments({this.index = 0, required this.pokemon});
  final Pokemon pokemon;
  final int? index;
}

class DetailContainer extends StatefulWidget {
  const DetailContainer({
    Key? key,
    required this.repository,
    required this.arguments,
    required this.onBack,
  }) : super(key: key);
  final IPokemonRepository repository;
  final DetailArguments arguments;
  final VoidCallback onBack;

  @override
  State<DetailContainer> createState() => _DetailContainerState();
}

class _DetailContainerState extends State<DetailContainer> {
  late PageController _controller;
  late Future<List<Pokemon>> _future;
  Pokemon? _pokemon;
  @override
  void initState() {
    _controller = PageController(
        viewportFraction: 0.5, initialPage: widget.arguments.index!);
    _future = widget.repository.getAllPokemons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Pokemon>>(
        future: _future,
        builder: (context, snaphot) {
          if (snaphot.connectionState == ConnectionState.waiting) {
            return const PoLoading();
          }

          if (snaphot.connectionState == ConnectionState.done &&
              snaphot.hasData) {
            // ignore: prefer_conditional_assignment
            if (_pokemon == null) {
              _pokemon = widget.arguments.pokemon;
            }
            return DetailPage(
              pokemon: _pokemon!,
              list: snaphot.data!,
              onBack: widget.onBack,
              controller: _controller,
              onChangePokemon: (Pokemon value) {
                setState(() {
                  _pokemon = value;
                });
              },
            );
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
