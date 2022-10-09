// To parse this JSON data, do
//
//     final productResposeModel = productResposeModelFromJson(jsonString);

import 'dart:convert';

List<ProductResposeModel> productResposeModelFromJson(String str) =>
    List<ProductResposeModel>.from(
        json.decode(str).map((x) => ProductResposeModel.fromJson(x)));

String productResposeModelToJson(List<ProductResposeModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductResposeModel {
  ProductResposeModel({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.rating,
  });

  int? id;
  String? title;
  double? price;
  String? description;
  Category? category;
  String? image;
  Rating? rating;

  factory ProductResposeModel.fromJson(Map<String, dynamic> json) =>
      ProductResposeModel(
        id: json["id"],
        title: json["title"],
        price: json["price"].toDouble(),
        description: json["description"],
        category: categoryValues.map![json["category"]],
        image: json["image"],
        rating: Rating.fromJson(json["rating"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "category": categoryValues.reverse[category],
        "image": image,
        "rating": rating!.toJson(),
      };
}

enum Category { MEN_S_CLOTHING, JEWELERY, ELECTRONICS, WOMEN_S_CLOTHING }

final categoryValues = EnumValues({
  "electronics": Category.ELECTRONICS,
  "jewelery": Category.JEWELERY,
  "men's clothing": Category.MEN_S_CLOTHING,
  "women's clothing": Category.WOMEN_S_CLOTHING
});

class Rating {
  Rating({
    this.rate,
    this.count,
  });

  double? rate;
  int? count;

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        rate: json["rate"].toDouble(),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "rate": rate,
        "count": count,
      };
}

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map!.map((k, v) => new MapEntry(v, k));
    return reverseMap!;
  }
}
