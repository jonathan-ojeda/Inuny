import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Models/product.dart';

class ApiProvider {
  Future<List<Producto>> getProductos({required bool sortByPrice}) async {
    final res = await http.get(Uri.parse('https://mi-api-rest.fly.dev/api')); //respuesta en texto
    final lista = List.from(jsonDecode(res.body));

    List<Producto> productos = [];
    lista.forEach((element) {
      final Producto product = Producto.fromJson(element);
      productos.add(product);
    });
    return productos;
  }
}
