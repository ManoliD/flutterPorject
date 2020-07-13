import 'dart:convert';

import 'package:dan_flutter_app/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'products_event.dart';
import 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  List<Product> list = [];
  int offset = 0;

  ProductsBloc() : super(ProductsInitialState());

  @override
  Stream<ProductsState> mapEventToState(ProductsEvent event) async* {
    if (event is FetchProducts) {
      await _fetchProducts();
      yield ProductsLoaded();
    }
    if (event is ReloadProducts) {
      yield ProductsLoaded();
    }
  }

  Future<void> _fetchProducts() async {
    var response = await http.get(
        "http://mobile-test.devebs.net:5000/products?limit=10&offset=$offset");
    if (response.statusCode == 200) {
      debugPrint(response.body);
      var responseData = json.decode(response.body);
      for (var element in responseData) {
        Product product = Product(
            element["id"],
            element["title"],
            element["short_description"],
            element["image"],
            element["price"],
            element["sale_precent"],
            element["details"],
            false);
        list.add(product);
      }
      offset += 10;
      debugPrint("Lista are " + list.length.toString() + "elemente");
    }

    return list;
  }

  void getProducts() {
    add(FetchProducts());
  }

  void addToFavourites(Product product) {
    for (int i = 0; i < list.length; i++) {
      if (list[i].id == product.id) {
        list[i].favourite = true;
      }
    }
    add(ReloadProducts());
  }

  void removeFromFavourites(Product product) {
    for (int i = 0; i < list.length; i++) {
      if (list[i].id == product.id) {
        list[i].favourite = false;
      }
    }
    add(ReloadProducts());
  }
}
