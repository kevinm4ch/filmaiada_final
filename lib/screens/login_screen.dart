import 'package:filmaiada/providers/auth_provider.dart';
import 'package:filmaiada/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  Future<void> login() async {

    try {
      await Provider.of<AppAuthProvider>(context, listen: false).signInWithGoogle();

      if (mounted) {
          Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.home, ModalRoute.withName(AppRoutes.login));
        }
      
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao fazer login: $e')),
        );
      }
    } 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Center(child: getBody(),) );
  }

  Widget getBody() {
    AppAuthProvider authProvider = Provider.of<AppAuthProvider>(context);
    if (authProvider.isSigningIn) {
      return const CircularProgressIndicator();
    } else if (authProvider.error != null) {
      return Text(authProvider.error!);
    } else {
      return ElevatedButton(
        onPressed: login,
        child: const Text('Login com Google'),
      );
    }
  }
}
