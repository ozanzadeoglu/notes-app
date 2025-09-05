import 'package:connectinno_case_client/domain/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authRepo = context.read<AuthRepository>();
    return Scaffold(
      body: Center(
        child: TextButton(onPressed: () => authRepo.signOut(), child: Text("Sign Out")),
      ));
  }
}