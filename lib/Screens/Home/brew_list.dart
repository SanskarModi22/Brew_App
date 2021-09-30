import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firestore/Models/brew.dart';
import 'package:flutter_firestore/Screens/Home/brew_tile.dart';
import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  const BrewList({Key? key}) : super(key: key);

  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>?>(context);

    return ListView.builder(
        itemCount: brews!.length,
        itemBuilder: (ctx, int index) {
          return BrewTile(
            brew: brews[index],
          );
        });
  }
}
