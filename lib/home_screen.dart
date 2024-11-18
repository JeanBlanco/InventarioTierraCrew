import 'package:flutter/material.dart';
import 'inventory_screen.dart';
import 'orders_screen.dart';
import 'sales_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tierra Crew'),
        backgroundColor: Colors.deepPurple[900],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildMenuButton(
              context,
              'Inventarios',
              Icons.inventory,
              Colors.yellow[700]!,
              InventoryScreen(),
            ),
            buildMenuButton(
              context,
              'Pedidos',
              Icons.shopping_cart,
              Colors.deepPurple[900]!,
              const OrdersScreen(),
            ),
            buildMenuButton(
              context,
              'Ventas',
              Icons.bar_chart,
              Colors.yellow[700]!,
              const SalesScreen(),
            ),
            buildMenuButton(
              context,
              'Configuración',
              Icons.settings,
              Colors.deepPurple[900]!,
              const SettingsScreen(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuButton(BuildContext context, String title, IconData icon,
      Color color, Widget screen) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          minimumSize: const Size(220, 50),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
          );
        },
        icon: Icon(icon, color: Colors.white),
        label: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
