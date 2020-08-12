import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

import 'bloc/bloc.dart';

class SavedList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SavedListState();
}

class _SavedListState extends State<SavedList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Saved"),
      ),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return StreamBuilder<Set<WordPair>>(
        stream: bloc.savedStream,
        builder: (context, snapshot) {
          var saved = Set<WordPair>();
          if (snapshot.hasData)
            saved.addAll(snapshot.data);
          else
            bloc.addCurrentSaved;

          return ListView.builder(
              itemCount: saved.length * 2 /*Divider 도 Item*/,
              itemBuilder: (context, index) {
                //짝수는 real items, 홀수는 dividers
                if (index.isOdd) return Divider();
                var realIndex = index ~/ 2;

                return _buildRow(snapshot.data.toList()[realIndex]);
              });
        });
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        textScaleFactor: 2,
      ),
      onTap: () {
        bloc.addToOrRemoveFromSavedList(pair);
      },
    );
  }
}
