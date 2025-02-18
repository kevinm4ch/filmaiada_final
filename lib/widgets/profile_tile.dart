
import 'package:flutter/material.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({super.key, required this.name, required this.color});

  final String name;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.only(top: 2.0, bottom: 2.0, right: 20.0),
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Text(
            name[0],
            style: const TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.w900),
          ),
        ),
        Text(
          name,
          style: Theme.of(context).textTheme.titleLarge,
        )
      ],
    );
  }
}
