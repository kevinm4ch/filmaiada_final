import 'package:flutter/material.dart';

class MovieDuration extends StatelessWidget {
  const MovieDuration({super.key, required this.duration});

  final int duration;

  @override
  Widget build(BuildContext context) {
    return Text("${duration ~/ 60}h ${duration % 60}min");
  }
}
