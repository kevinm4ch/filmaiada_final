import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class WatchListManager {
  final BuildContext context;

  WatchListManager(this.context);

  void showNotification(String message, {bool isError = false}) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: isError ? Colors.red : Colors.green,
      duration: const Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> toggleWatchList(String movieId) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String userId = user.uid;
        final testeToggle =
            FirebaseDatabase.instance.ref('watchLists/$userId/movies/$movieId');

        DatabaseEvent event = await testeToggle.once();
        if(event.snapshot.exists){
          await testeToggle.remove();
          showNotification("Filme removido da Watch List!");
        } else {
          await testeToggle.set(true);
          showNotification("Filme adicionado à Watch List!");
        }
      } else {
        showNotification("Nenhum usuário logado", isError: true);
      }
    } catch (e){
      showNotification("Erro ao atualizar Watch List: $e", isError: true);
    }
  }

  Future<bool> testeProBotao(String movieId) async {
  try {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userId = user.uid;
      final movieRef =
        FirebaseDatabase.instance.ref('watchLists/$userId/movies/$movieId');
      DatabaseEvent event = await movieRef.once();
      return event.snapshot.exists;
    } else {
      showNotification("Usuário não autenticado.", isError: true);
    }
  } catch (e) {
    showNotification("Erro ao verificar Watch List: $e", isError: true);
  }
  return false;
  }

}
