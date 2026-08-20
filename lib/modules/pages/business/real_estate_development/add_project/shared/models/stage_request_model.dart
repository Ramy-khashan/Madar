import 'package:equatable/equatable.dart';

class StageRequestModel extends Equatable {
  const StageRequestModel({
    required this.stageId,
    required this.subStageIds,
    this.customSubStages = const [],
  });

  final String stageId;
  final List<String> subStageIds;
  final List<String> customSubStages;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'stageId': stageId,
      'subStageIds': subStageIds,
    };
    if (customSubStages.isNotEmpty) {
      data['customSubStages'] = customSubStages;
    }
    return data;
  }

  @override
  List<Object?> get props => [stageId, subStageIds, customSubStages];
}
