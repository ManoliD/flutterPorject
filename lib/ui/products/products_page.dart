import 'package:dan_flutter_app/models/product.dart';
import 'package:dan_flutter_app/ui/Favorite/favorite_database.dart';
import 'package:dan_flutter_app/ui/Favorite/favorite_screen.dart';
import 'package:dan_flutter_app/ui/products/bloc/products_bloc.dart';
import 'package:dan_flutter_app/ui/products/bloc/products_state.dart';
import 'package:dan_flutter_app/ui/products/product_cell.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsPage extends StatefulWidget {
  ProductsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> with FavouriteEvents {
  ProductsBloc _productsBloc;
  ScrollController _controller;

  @override
  void initState() {
    _controller = ScrollController();
    FavoriteDataBaseSingleton().addListener(this);
    super.initState();
    _productsBloc = ProductsBloc();
    _productsBloc.getProducts();

    _controller.addListener(() {
      if (_controller.offset >= 0.7 * _controller.position.maxScrollExtent &&
          !_controller.position.outOfRange) {
        _productsBloc.getProducts();
      }
    });
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
      appBar: AppBar(
        leading: Icon(Icons.person_outline),
        centerTitle: true,
        title: Text(widget.title),
        actions: <Widget>[
          InkWell(
            child: Icon(Icons.shopping_cart),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FavoriteScreen()));
            },
          )
        ],
      ),
      // aici tre sa fie afisarea
      body: Center(
        child: BlocBuilder<ProductsBloc, ProductsState>(
          bloc: _productsBloc,
          // ignore: missing_return
          builder: (context, state) {
            if (state is ProductsLoaded) {
              return ListView.builder(
                controller: _controller,
                itemCount: _productsBloc.list.length,
                itemBuilder: (context, index) {
                  return ProductCell(_productsBloc.list[index]);
                },
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  @override
  void addToFavourites(Product product) {
    _productsBloc.addToFavourites(product);
  }

  @override
  void removeFromFavourites(Product product) {
    _productsBloc.removeFromFavourites(product);
  }
}
