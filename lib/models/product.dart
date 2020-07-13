
class Product {
   int id;
   String title;
   // ignore: non_constant_identifier_names
   String short_description;
   String image;
   int price;
   // ignore: non_constant_identifier_names
   int sale_precent;
   String details;
   bool favourite = false;

  Product(this.id, this.title, this.short_description, this.image, this.price,
      this.sale_precent, this.details, this.favourite);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'short_description': short_description,
      'image': image,
      'price': price,
      'sale_precent': sale_precent,
      'details': details
    };
  }

  Product.fromMap(Map<String, dynamic> maps) {
    this.id = maps['id'];
    this.title = maps['title'];
    this.short_description = maps['short_description'];
    this.image = maps['image'];
    this.price = maps['price'];
    this.sale_precent = maps['sale_precent'];
    this.details = maps['details'];
  }
}


