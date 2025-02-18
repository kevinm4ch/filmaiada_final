import 'package:filmaiada/widgets/profile_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre Nós'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Criadores:', style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),),
              const SizedBox(height: 10.0,),
              const ProfileTile(name: 'Kevin Machado', color: Colors.purple),
              const ProfileTile(name: 'Carlos Eduardo', color: Colors.blue),
              const SizedBox(height: 20.0,),
              Text('Projeto:', style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),),
              const SizedBox(height: 10.0,),
              const Text('Aplicação simples com uma lista de filmes selecionados onde o usuário pode escolher adicionar um filme a sua própria lista de filmes favoritos', textAlign: TextAlign.justify,),
              const SizedBox(height: 20.0,),
               Text('Repositório:', style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),),
              const SizedBox(height: 10.0,),
              ElevatedButton.icon(onPressed: (){
                Clipboard.setData(const ClipboardData(text: 'https://github.com/kevinm4ch/filmaiada'));
              }, label: const Text('Link para o repositório do Projeto'), icon: const Icon(Icons.copy),)
          ],
        ),
      )
    );
  }
}
