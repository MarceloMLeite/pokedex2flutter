import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pokedex2flutter/common/repository/pokemon_repository.dart';
import 'package:pokedex2flutter/features/pokedex/route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Pokedex 2.0',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: PokedexRoute(
        repository: PokemonRepository(
          dio: Dio(),
        ),
      ),
    );
  }
}
