class Banners {
  int? id;
  String? image;
  String? category;
  String? product;

  Banners.fromJson(Map<String, dynamic> jsonData) {
    id = jsonData['id'];
    image = jsonData['image'];
    category = jsonData['category'];
    product = jsonData['product'];
  }

  Map toJson() => {
      'id': this.id,
      'image': this.image,
      'category': this.category,
      'product': this.product
    };
    // Map<String, dynamic> data = {
    // data['id'] = this.id;
    // data['image'] = this.image;
    // data['category'] = this.category;
    // data['product'] = this.product;
    // }
    // return data;

}
