class RealStateProjectsModel {
  String? id;
  String? name;
  String? location;
  int? progress;
  String? status;
  String? lastUpdate;
  String? lastUpdateContent;
  String? managerName; 
  List<String>? attachments;

  RealStateProjectsModel(
      {this.id,
      this.name,
      this.location,
      this.progress,
      this.status,
      this.lastUpdate,
      this.lastUpdateContent,
      this.managerName,
      this.attachments
 });

  RealStateProjectsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    location = json['location'];
    progress = json['progress'];
    status = json['status'];
    lastUpdate = json['lastUpdate'];
    lastUpdateContent = json['lastUpdateContent'];
    managerName = json['managerName'];
    attachments = json['attachments'] != null
        ? List<String>.from(json['attachments'])
        : null;
    
  }
 
}
 