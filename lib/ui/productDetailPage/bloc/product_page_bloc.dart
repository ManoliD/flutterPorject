import 'dart:convert';

import 'package:dan_flutter_app/models/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'product_page_event.dart';
import 'product_page_state.dart';

class ProductDetailsBloc
    extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  String productId;
  Product productInfo;

  ProductDetailsBloc(this.productId) : super(ProductInitialState());

  @override
  Stream<ProductDetailsState> mapEventToState(
      ProductDetailsEvent event) async* {
    if (event is FetchProduct) {
      productInfo = await _getProductInfo();
      yield ProductFetched();
    } else if (event is ReloadProduct) {
      yield ProductFetched();
    }
  }

  Future<Product> _getProductInfo() async {
    var response = await http
        .get("http://mobile-test.devebs.net:5000/product?id=$productId");
    var responseData = json.decode(response.body);

    return Product(
        responseData["id"],
        responseData["title"],
        responseData["short_description"],
        responseData["image"],
        responseData["price"],
        responseData["sale_precent"],
        responseData["details"],
        false);
  }

  getProduct(){
    add(FetchProduct());
  }

  void addToFavourites(Product product) {
    if (productInfo.id == product.id) productInfo.favourite = true;
    add(ReloadProduct());
  }

  void removeFromFavourites(Product product) {
    if (productInfo.id == product.id) productInfo.favourite = false;
  }
}
