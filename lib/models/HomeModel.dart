class HomeModel
{
  bool? status;
  HomeData? data;

  HomeModel.fromJson(Map<String,dynamic>json)
  {
    status=json['status'];
    data=HomeData.fromJson(json['data']);
  }


}

class HomeData
{
  List<BannerModel>banners=[];
  List<ProductModel>products=[];

  HomeData.fromJson(Map<String,dynamic>json)
  {
    json['banners'].forEach((element){banners.add(BannerModel.fromjson(element));});
    json['products'].forEach((element){products.add(ProductModel.fromJson(element));});

  }
}

class BannerModel
{
  int? id;
  String? image;

  BannerModel.fromjson(Map<String,dynamic>json)
  {
    id=json['id'];
    image=json['image'];
  }

}

class ProductModel
{
  int? id;
  dynamic? price;
  dynamic? old_price;
  dynamic? discount;
  String? name;
  String? image;
  bool? in_favorites;
  bool? in_cart;

  ProductModel.fromJson(Map<String,dynamic>json)
  {
    id=json['id'];
    price=json['price'];
    old_price=json['old_price'];
    discount=json['discount'];
    name=json['name'];
    image=json['image'];
    in_cart=json['in_cart'];
    in_favorites=json['in_favorites'];

  }
}