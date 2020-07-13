import 'package:dan_flutter_app/models/product.dart';
import 'package:dan_flutter_app/ui/Favorite/favorite_database.dart';
import 'package:dan_flutter_app/ui/productDetailPage/product_detail_cell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/product_page_bloc.dart';
import 'bloc/product_page_state.dart';

class ProductDetailsPage extends StatefulWidget {
  final String productId;

  ProductDetailsPage({Key key, this.productId}) : super(key: key);

  @override
  ProductDetailsPageState createState() => ProductDetailsPageState();
}

class ProductDetailsPageState extends State<ProductDetailsPage>
    with FavouriteEvents {
  ProductDetailsBloc _productDetailsBloc;

  @override
  void initState() {
    super.initState();
    FavoriteDataBaseSingleton().addListener(this);
    _productDetailsBloc = ProductDetailsBloc(widget.productId);
    _productDetailsBloc.getProduct();
  }

  @override
  void dispose() {
    FavoriteDataBaseSingleton().removeListener(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:      AppBar(
        title: Text("product"),
      ),
      body: Center(
          child: BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
        bloc: _productDetailsBloc,
        builder: (context, state) {
          if (state is ProductFetched) {
            return ProductDetailCell(_productDetailsBloc.productInfo);
          } else {
            return CircularProgressIndicator();
          }
        },
      )),
    );
  }

  @override
  void addToFavourites(Product product) {
    _productDetailsBloc.addToFavourites(product);
  }

  @override
  void removeFromFavourites(Product product) {
    _productDetailsBloc.removeFromFavourites(product);
  }
}
