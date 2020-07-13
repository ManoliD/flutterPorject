import 'package:dan_flutter_app/models/product.dart';
import 'package:dan_flutter_app/ui/productDetailPage/product_details_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/favouite_screen_events.dart';
import 'bloc/favourite_screen_bloc.dart';
import 'bloc/favourite_screen_states.dart';
import 'favorite_database.dart';

class FavoriteScreenCell extends StatefulWidget {



  @override
  _FavoriteScreenCellState createState() => _FavoriteScreenCellState();

}
 class _FavoriteScreenCellState extends State<FavoriteScreenCell>{
   @override
   int taps = 0;
   Widget build(BuildContext context) {
     var _favouriteScreenBloc;
     return Scaffold(

         appBar: AppBar(
           centerTitle: true,
           title: Text(
             "Favourite Products",
             textAlign: TextAlign.center,
           ),
         ),
         backgroundColor: Colors.white,
         body: BlocBuilder<FavouriteScreenBloc, FavouriteScreenState>(
           bloc: _favouriteScreenBloc,
           builder: (context, state) {
             return ListView.builder(
                 itemCount: _favouriteScreenBloc.produse.length,
                 itemBuilder: (context, index) {
                   var now = (_favouriteScreenBloc.produse[index].price *
                       (_favouriteScreenBloc
                           .produse[index].sale_precent /
                           100) -
                       _favouriteScreenBloc.produse[index].price) *
                       -1;
                   var last = _favouriteScreenBloc.produse[index].price;
                   return Column(
                     children: <Widget>[
                       Container(
                         decoration: BoxDecoration(color: Colors.white),
                         margin: EdgeInsets.fromLTRB(00, 20, 00, 20),
                         child: InkWell(
                           highlightColor: Colors.white,
                           child: Image.network(
                             _favouriteScreenBloc.produse[index].image,
                             width: 200,
                             height: 200,
                           ),
                           onTap: () {
                             Navigator.push(
                               context,
                               MaterialPageRoute(
                                   builder: (context) => ProductDetailsPage(
                                       productId: _favouriteScreenBloc
                                           .produse[index].id
                                           .toString())),
                             );
                           },
                         ),
                       ),

                       Container(
                         color: Colors.white,
                         margin: EdgeInsets.fromLTRB(00, 5, 00, 5),
                         child: Text(
                           _favouriteScreenBloc.produse[index].title,
                           style: TextStyle(
                             fontSize: 28,
                           ),
                         ),
                       ),
                       Container(
                         color: Colors.white,
                         margin: EdgeInsets.fromLTRB(00, 5, 00, 5),
                         child: Text(
                           _favouriteScreenBloc.produse[index].short_description,
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
                               _favouriteScreenBloc.produse[index].sale_precent >
                                   0
                                   ? ' \$ $last'
                                   : "",
                               style: TextStyle(
                                   decoration: TextDecoration.lineThrough),
                             ),
                           ],
                         ),
                       ),
                       InkWell(
                         child: Icon(Icons.favorite_border,
                             size: 30, color: Colors.red),
                         onTap: () {
                           taps = taps + 1;
                           {
                             setState(() {
                               _favouriteScreenBloc.produse[index].favourite =
                               false;
                             });

                             _favouriteScreenBloc = FavouriteScreenBloc(
                                 FavouriteInitialState(),
                                 _favouriteScreenBloc.produse[index])
                               ..add(DeleteFromFavourites(
                                   _favouriteScreenBloc.produse[index]));
                             _favouriteScreenBloc = FavouriteScreenBloc(
                                 FavouriteInitialState(), null)
                               ..add(LoadFavourites());
                           }
                         },
                       ),
                       Divider(
                         thickness: 0,
                         color: Colors.grey,
                       ),
                       // Widget to display the list of project
                     ],
                   );
                 });
           },
         ));
   }
 }