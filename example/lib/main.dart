import 'package:breaking_bapp/presentation/character_list_screen.dart';
import 'package:breaking_bapp/presentation/pull_to_refresh/character_list_view.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Infinite Scroll Pagination Sample',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: MaterialApp(
          builder: (context, child) {
            return Scaffold(
              body: CharacterListView(),
            );
          },
        ),
      );
}
