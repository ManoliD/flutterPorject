import 'package:dan_flutter_app/models/product.dart';
import 'package:dan_flutter_app/ui/Favorite/favorite_database.dart';
import 'package:dan_flutter_app/ui/ProductDetailPage/product_details_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class ProductCell extends StatefulWidget {
  ProductCell(this.product);

  final Product product;

  @override
  _ProductCellState createState() => _ProductCellState();
}

class _ProductCellState extends State<ProductCell> {
  @override
  Widget build(BuildContext context) {
    var now = (widget.product.price * (widget.product.sale_precent / 100) -
            widget.product.price) *
        -1;
    var last = widget.product.price;

    return Container(
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.white),
            margin: EdgeInsets.fromLTRB(00, 20, 00, 20),
            child: InkWell(
              highlightColor: Colors.white,
              child: Image.network(
                widget.product.image,
                width: 200,
                height: 200,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductDetailsPage(
                              productId: widget.product.id.toString(),

                            )));
              },
            ),
          ),

          Container(
            color: Colors.white,
            margin: EdgeInsets.fromLTRB(00, 5, 00, 5),
            child: Text(
              widget.product.title,
              style: TextStyle(
                fontSize: 28,
              ),
            ),
          ),
          Container(
            color: Colors.white,
            margin: EdgeInsets.fromLTRB(00, 5, 00, 5),
            child: Text(
              widget.product.short_description,
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            color: Colors.white,
            margin: EdgeInsets.fromLTRB(00, 5, 00, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('\$ $now ',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.deepPurple)),
                Text(
                  widget.product.sale_precent > 0 ? ' \$ $last' : "",
                  style: TextStyle(decoration: TextDecoration.lineThrough),
                ),
              ],
            ),
          ),
          InkWell(
            child: Icon(
              Icons.favorite_border,
              size: 30,
              color: widget.product.favourite ? Colors.red : Colors.black,
            ),
            onTap: () {
              if (widget.product.favourite) {
                FavoriteDataBaseSingleton().removeFromFavourite(widget.product);
              } else {
                FavoriteDataBaseSingleton().addToFavourite(widget.product);
              }
            },
          ),
          Divider(
            thickness: 0,
            color: Colors.grey,
          ),
          // Widget to display the list of project
        ],
      ),
    );
  }
}
