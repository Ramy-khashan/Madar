import '../../property_details/model/property_details_model.dart';

class PortfolioPropertyModel {
  String? id;
  String? title;
  String? location;
  String? imageUrl;
  String? status;
  String? typeId;
  int? bed;
  int? bath;
  String? area;
  bool? isForSale;

  PortfolioPropertyModel({
    this.id,
    this.title,
    this.location,
    this.imageUrl,

    this.typeId = '',
    this.bed,
    this.bath,
    this.area,
    this.isForSale = true,
    this.status,
  });
  PortfolioPropertyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    location = json['location'];
    imageUrl = PropertyMedia.coverFrom(
      json['media'],
      fallback: (json['imageUrl'] ?? json['mainImage'] ?? json['image'])
          ?.toString(),
    );
    status = json['status'];
    bed = json['bed'];
    bath = json['bath'];
    area = json['area'];
    typeId = json['typeId'];
    isForSale = json['isForSale'];
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'location': location,
      'imageUrl': imageUrl,
      'status': status,
      'bed': bed,
      'bath': bath,
      'area': area,
      'typeId': typeId,
      'isForSale': isForSale,
    };
  }
}
