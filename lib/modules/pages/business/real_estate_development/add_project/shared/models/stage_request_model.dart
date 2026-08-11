import 'package:equatable/equatable.dart';

class StageRequestModel extends Equatable {
  const StageRequestModel({
    required this.stageId,
    required this.subStageIds,
  });

  final String stageId;
  final List<String> subStageIds;

  Map<String, dynamic> toJson() {
    return {
      'stageId': stageId,
      'subStageIds': subStageIds,
    };
  }

  @override
  List<Object?> get props => [stageId, subStageIds];
}
