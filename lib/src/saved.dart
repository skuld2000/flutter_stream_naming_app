import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class SavedList extends StatefulWidget {
  SavedList({@required this.saved});

  final Set<WordPair> saved;

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
    return ListView.builder(
        itemCount: widget.saved.length * 2 /*Divider 도 Item*/,
        itemBuilder: (context, index) {
          //짝수는 real items, 홀수는 dividers
          if (index.isOdd) return Divider();
          var realIndex = index ~/ 2;

          return _buildRow(widget.saved.toList()[realIndex]);
        });
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        textScaleFactor: 2,
      ),
      onTap: () {
        setState(() {
          widget.saved.remove(pair);

          print(widget.saved.toString());
        });
      },
    );
  }
}
