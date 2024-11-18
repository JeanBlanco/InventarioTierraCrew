import 'package:flutter/material.dart';

class ViewProductsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  const ViewProductsScreen({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ver Productos'),
        backgroundColor: Colors.deepPurple[900],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            title: Text(product['nombre']),
            subtitle: Text(
                'Unidades: ${product['cantidad']}, Precio Unitario: \$${product['precio']}'),
            trailing: Text(
                'Total: \$${(product['cantidad'] * product['precio']).toStringAsFixed(2)}'),
            onTap: () => _showProductDetails(context, product),
          );
        },
      ),
    );
  }

  void _showProductDetails(BuildContext context, Map<String, dynamic> product) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(product['nombre']),
          content: Text(
            'Talla: ${product['talla']}\n'
            'Color: ${product['color']}\n'
            'Precio: \$${product['precio']}\n'
            'Cantidad: ${product['cantidad']}\n'
            'Fecha Última Modificación: ${product['fecha']}',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}
