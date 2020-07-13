abstract class ProductsEvent extends Object {}

class FetchProducts extends ProductsEvent {
  FetchProducts();
}

class ReloadProducts extends ProductsEvent {
  ReloadProducts();
}
