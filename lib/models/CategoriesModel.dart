class CategoriesModel
{
  bool? status;
  CategoryDataModel? data;

  CategoriesModel.fromJson(Map<String,dynamic>json)
  {
    status=json['status'];
    data=CategoryDataModel.fromJson(json['data']);
    
  }
}

class CategoryDataModel
{
  int? current_page;
  // String? first_page_url;
  // int? from;
  // String? last_page_url;
  // String?path;
  // int? per_page;
  // int? to;
  // int? total;

  List<DataModel>data=[];


  CategoryDataModel.fromJson(Map<String,dynamic>json)
  {

    current_page=json['current_page'];

    json['data'].forEach((element){data.add(DataModel.fromJson(element));});



  }
}

class DataModel
{
  int? id;
  String? name;
  String? image;

  DataModel.fromJson(Map<String,dynamic>json)
  {
    id=json['id'];
    name=json['name'];
    image=json['image'];
  }
}