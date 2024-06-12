import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ferretera',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MenuPage(),
    );
  }
}

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  void _navigateTo(BuildContext context, String page) {
    Widget targetPage;
    switch (page) {
      case 'Proveedores':
        targetPage = const ProveedoresPage();
        break;
      case 'Productos':
        targetPage = const ProductosPage();
        break;
      case 'Clientes':
        targetPage = const ClientesPage();
        break;
      default:
        targetPage = const MenuPage();
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => targetPage),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Ferretera'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => _navigateTo(context, 'Proveedores'),
              child: const Text('Proveedores'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _navigateTo(context, 'Productos'),
              child: const Text('Productos'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _navigateTo(context, 'Clientes'),
              child: const Text('Clientes'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProveedoresPage extends StatefulWidget {
  const ProveedoresPage({super.key});

  @override
  _ProveedoresPageState createState() => _ProveedoresPageState();
}

class _ProveedoresPageState extends State<ProveedoresPage> {
  final List<Map<String, String>> _proveedores = [];
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _tipoProductoController = TextEditingController();
  final TextEditingController _precioController = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();

  void _addProveedor() {
    setState(() {
      _proveedores.add({
        'Nombre': _nombreController.text,
        'TipoProducto': _tipoProductoController.text,
        'Precio': _precioController.text,
        'Direccion': _direccionController.text,
        'Descripcion': _descripcionController.text,
      });
      _nombreController.clear();
      _tipoProductoController.clear();
      _precioController.clear();
      _direccionController.clear();
      _descripcionController.clear();
    });
  }

  void _deleteProveedor(int index) {
    setState(() {
      _proveedores.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Proveedores'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nombreController,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _tipoProductoController,
              decoration: const InputDecoration(
                labelText: 'Tipo de Producto',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _precioController,
              decoration: const InputDecoration(
                labelText: 'Precio',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _direccionController,
              decoration: const InputDecoration(
                labelText: 'Dirección',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _descripcionController,
              decoration: const InputDecoration(
                labelText: 'Descripción',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addProveedor,
              child: const Text('Agregar'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _proveedores.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_proveedores[index]['Nombre']!),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Tipo de Producto: ${_proveedores[index]['TipoProducto']}'),
                        Text('Precio: ${_proveedores[index]['Precio']}'),
                        Text('Dirección: ${_proveedores[index]['Direccion']}'),
                        Text('Descripción: ${_proveedores[index]['Descripcion']}'),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _deleteProveedor(index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductosPage extends StatelessWidget {
  const ProductosPage({super.key});

  void _navigateToAddProduct(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddProductPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Productos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => _navigateToAddProduct(context),
              child: const Text('Agregar Producto'),
            ),
            const SizedBox(height: 20),
            const Expanded(
              child: ViewProductsPage(),
            ),
          ],
        ),
      ),
    );
  }
}

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _marcaController = TextEditingController();
  final TextEditingController _precioController = TextEditingController();
  final TextEditingController _categoriaController = TextEditingController();

  void _addProducto() {
    final product = {
      'Nombre': _nombreController.text,
      'Marca': _marcaController.text,
      'Precio': _precioController.text,
      'Categoria': _categoriaController.text,
    };
    Navigator.pop(context, product);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Agregar Producto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nombreController,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _marcaController,
              decoration: const InputDecoration(
                labelText: 'Marca',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _precioController,
              decoration: const InputDecoration(
                labelText: 'Precio',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _categoriaController,
              decoration: const InputDecoration(
                labelText: 'Categoría',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addProducto,
              child: const Text('Agregar'),
            ),
          ],
        ),
      ),
    );
  }
}

class ViewProductsPage extends StatefulWidget {
  const ViewProductsPage({super.key});

  @override
  _ViewProductsPageState createState() => _ViewProductsPageState();
}

class _ViewProductsPageState extends State<ViewProductsPage> {
  final List<Map<String, String>> _productos = [
    {
      'Nombre': 'Martillo',
      'Marca': 'Stanley',
      'Precio': '10.00',
      'Categoria': 'Herramientas',
    },
    {
      'Nombre': 'Taladro',
      'Marca': 'Bosch',
      'Precio': '50.00',
      'Categoria': 'Herramientas',
    }
  ];

  void _addProduct(Map<String, String> product) {
    setState(() {
      _productos.add(product);
    });
  }

  void _deleteProducto(int index) {
    setState(() {
      _productos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _productos.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_productos[index]['Nombre']!),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Marca: ${_productos[index]['Marca']}'),
                    Text('Precio: ${_productos[index]['Precio']}'),
                    Text('Categoría: ${_productos[index]['Categoria']}'),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _deleteProducto(index),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class ClientesPage extends StatefulWidget {
  const ClientesPage({super.key});

  @override
  _ClientesPageState createState() => _ClientesPageState();
}

class _ClientesPageState extends State<ClientesPage> {
  final List<Map<String, String>> _clientes = [];
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidosController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();

  void _addCliente() {
    setState(() {
      _clientes.add({
        'Nombres': _nombreController.text,
        'Apellidos': _apellidosController.text,
        'Telefono': _telefonoController.text,
        'Direccion': _direccionController.text,
      });
      _nombreController.clear();
      _apellidosController.clear();
      _telefonoController.clear();
      _direccionController.clear();
    });
  }

  void _deleteCliente(int index) {
    setState(() {
      _clientes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Clientes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nombreController,
              decoration: const InputDecoration(
                labelText: 'Nombres',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _apellidosController,
              decoration: const InputDecoration(
                labelText: 'Apellidos',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _telefonoController,
              decoration: const InputDecoration(
                labelText: 'Teléfono',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _direccionController,
              decoration: const InputDecoration(
                labelText: 'Dirección',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addCliente,
              child: const Text('Agregar'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _clientes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_clientes[index]['Nombres']!),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Apellidos: ${_clientes[index]['Apellidos']}'),
                        Text('Teléfono: ${_clientes[index]['Telefono']}'),
                        Text('Dirección: ${_clientes[index]['Direccion']}'),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _deleteCliente(index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
