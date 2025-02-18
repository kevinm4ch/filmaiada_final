
import 'package:filmaiada/utils/routes.dart';
import 'package:filmaiada/widgets/user_profile_image.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DrawerHeader(
                child: Column(
              spacing: 20,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.movie,
                      size: 48.0,
                    ),
                    const SizedBox(width: 20),
                    Text(
                      'Filmaiada',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                Row(
                  spacing: 10,
                  children: [
                    UserProfileImage(),
                    Text(user == null ? 'Anonimo' : user.displayName!),
                  ],                 
                )
              ],
            )),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.aboutUs);
              },
              child: const Card(
                  child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.info_outline),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text('Sobre nós')
                  ],
                ),
              )),
            )
          ],
        ),
      ),
    );
  }
}

