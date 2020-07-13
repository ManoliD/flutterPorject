import 'package:dan_flutter_app/models/product.dart';

abstract class FavouriteScreenEvents extends Object {
}

class LoadFavourites extends FavouriteScreenEvents{}
class ReloadFavourites extends FavouriteScreenEvents{}
class DeleteFromFavourites extends FavouriteScreenEvents {
  Product product;

  DeleteFromFavourites(this.product);
}