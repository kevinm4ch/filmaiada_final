import 'package:filmaiada/utils/favoritar.dart';
import 'package:flutter/material.dart';

class ToggleWatchListButton extends StatefulWidget {
  final String movieId;

  const ToggleWatchListButton({super.key, required this.movieId});

  @override
  ToggleWatchListButtonState createState() => ToggleWatchListButtonState();
}

class ToggleWatchListButtonState extends State<ToggleWatchListButton> {
  late WatchListManager manager;
  bool isInList = false;

  @override
  void initState() {
    super.initState();
    manager = WatchListManager(context);
    checkWatchListStatus();
  }

  void checkWatchListStatus() async {
    bool status = await manager.testeProBotao(widget.movieId);
    setState(() {
      isInList = status;
    });
  }

  void toggleWatchList() async {
    await manager.toggleWatchList(widget.movieId);
    checkWatchListStatus();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: toggleWatchList,
      icon: Icon(
        isInList ? Icons.playlist_add_check : Icons.playlist_add,
        color: isInList ? Colors.green : Colors.white,
      ),
      tooltip: isInList
          ? "Remover da Watch List"
          : "Adicionar à Watch List", // Tooltip para acessibilidade
    );
  }
}