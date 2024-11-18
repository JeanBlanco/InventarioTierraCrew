import 'package:flutter/material.dart';
import 'view_products_screen.dart';

class InventoryScreen extends StatefulWidget {
  @override
  _InventoryScreenState createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  // Lista para almacenar los productos del inventario
  final List<Map<String, dynamic>> _inventory = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventarios'),
        backgroundColor: Colors.deepPurple[900],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildOptionButton(context, 'Cargar Producto', Icons.add_circle,
                Colors.yellow[700]!, _addProduct),
            buildOptionButton(context, 'Descargar Producto',
                Icons.remove_circle, Colors.deepPurple[900]!, _removeProduct),
            buildOptionButton(context, 'Ver Productos', Icons.list,
                Colors.yellow[700]!, _viewProducts),
            buildOptionButton(
                context,
                'Informe de Inventario',
                Icons.insert_chart,
                Colors.deepPurple[900]!,
                _viewInventoryReport),
          ],
        ),
      ),
    );
  }

  Widget buildOptionButton(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          minimumSize: const Size(250, 50),
        ),
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.white),
        label: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }

  // Función para cargar producto
  void _addProduct() {
    showDialog(
      context: context,
      builder: (context) {
        final TextEditingController nameController = TextEditingController();
        final TextEditingController sizeController = TextEditingController();
        final TextEditingController colorController = TextEditingController();
        final TextEditingController priceController = TextEditingController();
        final TextEditingController quantityController =
            TextEditingController();

        return AlertDialog(
          title: const Text('Cargar Producto'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                _buildTextField(nameController, 'Nombre del producto'),
                _buildTextField(sizeController, 'Talla'),
                _buildTextField(colorController, 'Color'),
                _buildTextField(priceController, 'Precio', isNumeric: true),
                _buildTextField(quantityController, 'Cantidad',
                    isNumeric: true),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _inventory.add({
                    'nombre': nameController.text,
                    'talla': sizeController.text,
                    'color': colorController.text,
                    'precio': double.tryParse(priceController.text) ?? 0.0,
                    'cantidad': int.tryParse(quantityController.text) ?? 0,
                    'fecha': DateTime.now(), // Fecha y hora de carga
                  });
                });
                Navigator.pop(context);
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  // Función para descargar producto
  void _removeProduct() {
    if (_inventory.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No hay productos en el inventario')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Descargar Producto'),
          content: SingleChildScrollView(
            child: Column(
              children: _inventory.map((product) {
                return ListTile(
                  title: Text(product['nombre']),
                  subtitle: Text('Cantidad disponible: ${product['cantidad']}'),
                  trailing: const Icon(Icons.remove_circle, color: Colors.red),
                  onTap: () {
                    setState(() {
                      product['cantidad'] = (product['cantidad'] as int) - 1;
                      if (product['cantidad'] <= 0) {
                        _inventory.remove(product);
                      } else {
                        product['fecha'] = DateTime.now(); // Fecha de descarga
                      }
                    });
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  // Nueva función para ver productos
  void _viewProducts() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewProductsScreen(products: _inventory),
      ),
    );
  }

  // Nueva función para el informe de inventario
  void _viewInventoryReport() {
    showDialog(
      context: context,
      builder: (context) {
        final Map<String, double> monthlyTotals = {};
        for (var product in _inventory) {
          final date = product['fecha'] as DateTime;
          final month = '${date.month}/${date.year}';
          monthlyTotals[month] = (monthlyTotals[month] ?? 0) +
              ((product['precio'] as double) * (product['cantidad'] as int));
        }

        return AlertDialog(
          title: const Text('Informe de Inventario'),
          content: SingleChildScrollView(
            child: Column(
              children: monthlyTotals.entries.map((entry) {
                return ListTile(
                  title: Text('Mes: ${entry.key}'),
                  subtitle: Text('Total: \$${entry.value.toStringAsFixed(2)}'),
                );
              }).toList(),
            ),
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

  // Widget auxiliar para construir campos de texto
  Widget _buildTextField(TextEditingController controller, String label,
      {bool isNumeric = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: TextField(
        controller: controller,
        keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
