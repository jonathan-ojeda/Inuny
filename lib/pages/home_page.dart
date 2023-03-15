import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/Models/product.dart';
import '../data/Provider/shopping_cart.dart';
import '../data/repositories/api.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _productos = ApiProvider();

  //final _cart = Cart();

  @override
  void initState() {
    super.initState();
  }

  bool _sortByPriceAscending = true;
  var _sortIcon = Icons.arrow_upward;
  int _numItemsEnCarrito = 0;

  @override
  Widget build(BuildContext context) {
    final Cart _cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'In',
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFAFAFA), // Color del texto
              ),
            ),
            Container(
                height: 20, width: 20, child: Image.asset('assets/img.png')),
            Text(
              'ny',
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFAFAFA), // Color del texto
              ),
            ),
          ],
        )),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/details');
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/shopp');
                      },
                      icon: Icon(
                        Icons.shopping_cart,
                        color: Color(0xFFFAFAFA),
                      ),
                    ),
                    if (_numItemsEnCarrito > 0)
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            _numItemsEnCarrito.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'Producto',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Precio',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _productos.getProductos(sortByPrice: true);
                          _sortByPriceAscending = !_sortByPriceAscending;
                          _sortIcon = _sortByPriceAscending
                              ? Icons.arrow_upward
                              : Icons.arrow_downward;
                        });
                      },
                      icon: Icon(_sortIcon, color: Color(0xFF8C8C8C)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: FutureBuilder<List<Producto>>(
              future:
                  _productos.getProductos(sortByPrice: _sortByPriceAscending),
              builder: (context, snap) {
                if (snap.hasData) {
                  if (_sortByPriceAscending) {
                    snap.data!.sort((a, b) => a.precio.compareTo(b.precio));
                  } else {
                    snap.data!.sort((a, b) => b.precio.compareTo(a.precio));
                  }
                  return ListView.builder(
                    itemCount: snap.data!.length,
                    itemBuilder: (context, i) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFFAFAFA),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Color(0xFFD2D2D2),
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: ListTile(
                                        title: Text(
                                          snap.data![i].nombre,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        subtitle: Image.network(
                                          snap.data![i].img,
                                          width: 30,
                                          height: 80,
                                          fit: BoxFit.contain,
                                          alignment: Alignment.centerLeft,
                                        ),
                                      ),
                                    ),
                                    MaterialButton(
                                      color: Color(0xFF33C283),
                                        onPressed: () {
                                        setState(() {
                                          _mostrarAlertaDetalle(context, snap.data![i]);
                                        });
                                        },
                                        child: Text("Detalle", style: TextStyle(color: Colors.white),)),

                                    Container(
                                      child: Column(
                                        children: [
                                          Text(
                                            snap.data![i].precio.toString() +
                                                " pesos",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    final productId =
                                                        snap.data![i].id;
                                                    final productTitle =
                                                        snap.data![i].nombre;
                                                    final productPrice = snap
                                                        .data![i].precio
                                                        .toDouble();
                                                    if (_cart.items.containsKey(
                                                        productId)) {
                                                      final cartItem = _cart
                                                          .items[productId]!;
                                                      cartItem
                                                          .quantity++; // Actualizar cantidad en el CartItem
                                                      _cart.setSelectedQuantity(
                                                          productId,
                                                          cartItem
                                                              .quantity); // Actualizar cantidad seleccionada
                                                    } else {
                                                      _cart.addItem(
                                                          productId,
                                                          productTitle,
                                                          productPrice); // Agregar nuevo item
                                                      _cart.setSelectedQuantity(
                                                          productId,
                                                          1); // Inicializar cantidad seleccionada
                                                      _numItemsEnCarrito++; // Incrementar número total de items en el carrito
                                                    }
                                                  });
                                                },
                                                icon: Icon(
                                                  Icons.add_shopping_cart,
                                                  color: Color(0xFF33C283),
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    final productId =
                                                        snap.data![i].id;
                                                    if (_cart.items.containsKey(
                                                        productId)) {
                                                      final cartItem = _cart
                                                          .items[productId]!;
                                                      if (cartItem.quantity >
                                                          0) {
                                                        cartItem
                                                            .quantity--; // Actualizar cantidad en el CartItem
                                                        _cart.setSelectedQuantity(
                                                            productId,
                                                            cartItem
                                                                .quantity); // Actualizar cantidad seleccionada
                                                        print(_cart
                                                            .getSelectedQuantity(
                                                                productId));
                                                      } else if (cartItem
                                                              .quantity ==
                                                          0) {
                                                        print(
                                                            "Removing item from cart...");
                                                        _numItemsEnCarrito--; // Decrementar número total de items en el carrito
                                                        _cart.removeItem(
                                                            productId);
                                                      }
                                                    }
                                                  });
                                                },
                                                icon: Icon(
                                                  Icons.remove_shopping_cart,
                                                  color: Colors.redAccent,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "Cantidad: ${_cart.items[snap.data![i].id]?.quantity?.toString() ?? '0'}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          //const Divider(),
                        ],
                      );
                    },
                  );
                }
                if (snap.hasError) {
                  return const Center(
                    child: Text("Ha habido un problema"),
                  );
                }

                return Center(
                  child: const CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _mostrarAlertaDetalle(BuildContext context,  detalle) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Image.network(
            detalle.img,
            width: 30,
            height: 80,
            fit: BoxFit.contain,
            alignment: Alignment.center,
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Nombre: "+detalle.nombre.toString()),
              Text("Precio: "+detalle.precio.toString()),
              Text("Fecha de Creación: "+detalle.fechaCracion.toString()),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}
