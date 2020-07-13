import 'package:dan_flutter_app/models/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../favorite_database.dart';
import 'favouite_screen_events.dart';
import 'favourite_screen_states.dart';

class FavouriteScreenBloc
    extends Bloc<FavouriteScreenEvents, FavouriteScreenState> {
  FavouriteScreenBloc(FavouriteScreenState initialState, this.product) : super(initialState);
  List<Product> produse = List();
  Product product;


  @override
  Stream<FavouriteScreenState> mapEventToState(FavouriteScreenEvents event) async* {
    if (event is LoadFavourites) {
      produse = await all_products();
      yield FavouriteSuccess(produse);
    }
    if (event is DeleteFromFavourites) {
      FavoriteDataBaseSingleton().removeFromFavourite(product);
    }
  }

  // ignore: non_constant_identifier_names
  Future<List<Product>> all_products() async {
    produse = await FavoriteDataBaseSingleton().all_products();
    return produse;
  }

  void addToFavourites(Product product) {
    for(int i = 0; i < produse.length; i++) {
      if (produse[i].id == product.id) {
        produse[i].favourite = true;
        return;
      }
    }
  }

  void removeFromFavourites(Product product) {
    for(int i = 0; i < produse.length; i++) {
      if (produse[i].id == product.id) {
        produse[i].favourite = false;
        return;
      }
    }
  }
}

