import 'package:flutter/material.dart';

class NoteButton extends StatelessWidget {
  const NoteButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        Navigator.pushNamed(context, "/note");
      },
      icon: Icon(Icons.note),
      label: Text("小记"),
    );
  }
}
