class Products {

  int? id;
  dynamic? price;
  dynamic? oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;
  List<dynamic>? images;
  bool? inFavorite;
  bool? inCart;

  Products.fromJson(Map<String, dynamic> jsonData){
    id = jsonData['id'];
    price = jsonData['price'];
    oldPrice = jsonData['old_price'];
    discount = jsonData['discount'];
    image = jsonData['image'];
    name = jsonData['name'];
    description = jsonData['description'];
    images = jsonData['images'];
    inFavorite = jsonData['in_favorites'];
    inCart = jsonData['in_cart'];
  }

  Map<String, dynamic> toJson() => {};
}
