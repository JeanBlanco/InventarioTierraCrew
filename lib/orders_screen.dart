import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos'),
        backgroundColor: Colors.deepPurple[900],
      ),
      body: const Center(
        child: Text('Pantalla de Pedidos'),
      ),
    );
  }
}
