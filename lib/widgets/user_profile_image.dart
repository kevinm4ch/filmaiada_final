import 'package:filmaiada/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class UserProfileImage extends StatefulWidget {
  const UserProfileImage({super.key});

  @override
  State<UserProfileImage> createState() => _UserProfileImageState();
}

class _UserProfileImageState extends State<UserProfileImage> {
  void _takePicture(AppAuthProvider auth) async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);

    if (pickedImage == null) {
      return;
    }

    auth.image = File(pickedImage.path);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppAuthProvider>(
      builder: (ctx, auth, child) {
        if (auth.image == null) {
          return InkWell(
            onTap: () {
              _takePicture(auth);
            },
            child: CircleAvatar(
              minRadius: 30,
              backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(Icons.person),
            ),
          );
        }

        return ClipOval(
            child: Image.file(
              auth.image!, // URL da imagem
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          );
      },
    );
  }
}
