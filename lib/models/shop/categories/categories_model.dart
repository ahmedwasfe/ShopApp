

class Categories{
  bool? status;
  String? message;
  CategoriesData? data;

  Categories.empty();

  Categories.fromJson(Map<String, dynamic> jsonData){
    status = jsonData['status'];
    message = jsonData['message'];
    data = CategoriesData.fromJson(jsonData['data']);
  }
}

class Category {
  int? id;
  String? name;
  String? image;

  Category.fromJson(Map<String, dynamic> jsonData) {
    id = jsonData['id'];
    name = jsonData['name'];
    image = jsonData['image'];
  }
}

class CategoriesData {

  int? currentPage;
  List<Category>? categories;
  String? firstPageUrl;
  String? lastPageUrl;
  String? nextPageUrl;
  String? prevPageUrl;
  String? path;
  int? lastPage;
  int? perPage;
  int? from;
  int? to;
  int? total;

  CategoriesData.fromJson(Map<String, dynamic> jsonData){
    currentPage = jsonData['current_page'];
    if(jsonData['data'] != null){
      categories = [];
      jsonData['data'].forEach((elemet) => categories!.add(Category.fromJson(elemet)));
    }
    firstPageUrl = jsonData['first_page_url'];
    lastPageUrl = jsonData['last_page_url'];
    nextPageUrl = jsonData['next_page_url'];
    prevPageUrl = jsonData['prev_page_url'];
    path = jsonData['path'];
    lastPage = jsonData['last_page'];
    perPage = jsonData['per_page'];
    from = jsonData['from'];
    to = jsonData['to'];
    total = jsonData['total'];
  }

}