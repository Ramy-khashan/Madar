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
    imageUrl = json['imageUrl'];
    status = json['status'];
    bed = json['bed'];
    bath = json['bath'];
    area = json['area'];
    typeId = json['typeId'];
    isForSale = json['isForSale'];
  }
}
