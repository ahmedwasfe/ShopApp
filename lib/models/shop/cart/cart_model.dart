
class Cart {
  bool? status;
  String? message;
  CartData? cartData;

  Cart.fromJson(Map<String, dynamic> jsonData) {
    status = jsonData['status'];
    message = jsonData['message'];
    cartData = jsonData['data'] != null ? CartData.fromJson(jsonData['data']) : null;
  }
}

class CartData {
  List<CartItems>? cartItems;
  double? subTotal;
  double? total;


  CartData.empty(){}

  CartData.fromJson(Map<String, dynamic> jsonData){
    if(jsonData['cart_items'] != null){
      cartItems = [];
      jsonData['cart_items'].forEach((element) {
        cartItems!.add(CartItems.fromJson(element));
      });
    }
    subTotal = jsonData['sub_total'];
    total = jsonData['total'];
  }

}

class CartItems{
  int? id;
  int? quantity;
  Product? product;

  CartItems.fromJson(Map<String, dynamic> jsonData){
    id = jsonData['id'];
    quantity = jsonData['quantity'];
    product = jsonData['product'] != null ? Product.fromJson(jsonData['product']) : null;
  }
}

class Product {
  int? id;
  dynamic? price;
  dynamic? oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;
  List<String>? images;
  bool? inFavorites;
  bool? inCart;

  Product.fromJson(Map<String, dynamic> jsonData) {
    id = jsonData['id'];
    price = jsonData['price'];
    oldPrice = jsonData['old_price'];
    discount = jsonData['discount'];
    image = jsonData['image'];
    name = jsonData['name'];
    description = jsonData['description'];
    if(jsonData['images'] != null){
      images = jsonData['images'].cast<String>();
    }
    inFavorites = jsonData['in_favorites'];
    inCart = jsonData['in_cart'];
  }
}
