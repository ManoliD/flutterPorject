import 'package:dan_flutter_app/models/product.dart';
import 'package:dan_flutter_app/ui/Favorite/favorite_screen_cell.dart';

abstract class FavouriteScreenState extends Object {}

class FavouriteInitialState extends FavouriteScreenState{}
class FavouriteSuccess extends FavouriteScreenState{
  final List<Product> produse;
  FavouriteSuccess(this.produse);
}
class FavouriteDeleted extends FavouriteScreenState{
  final Product product;
  FavouriteDeleted(this.product);
}
class FavoriteScreenCellState extends FavoriteScreenCell{

}