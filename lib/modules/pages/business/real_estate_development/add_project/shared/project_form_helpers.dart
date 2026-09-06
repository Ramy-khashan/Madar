import 'package:intl/intl.dart';

import '../../../../../../core/utils/constants/app_strings.dart';
import 'models/manager_request_model.dart';
import 'models/project_request_base.dart';
import 'models/project_stage_model.dart';
import 'models/stage_request_model.dart';

class ProjectFormHelpers {
  ProjectFormHelpers._();

  static final DateFormat apiDateFormat = DateFormat('yyyy-MM-dd');

  static String formatApiDate(DateTime date) => apiDateFormat.format(date);

  static String cleanPrice(String raw) =>
      raw.trim().replaceAll(RegExp(r'[^\d.]'), '');

  static List<String> selectableSubStageIds(ProjectStageModel stage) =>
      stage.subStages.where((s) => !s.isOther).map((s) => s.id).toList();

  static bool areAllSelectableSelected(
    ProjectStageModel stage,
    List<String> selectedSubIds,
  ) {
    final ids = selectableSubStageIds(stage);
    return ids.isNotEmpty && ids.every(selectedSubIds.contains);
  }

  static ({
    List<String> selectedStageIds,
    Map<String, List<String>> selectedSubStageIds,
  })
  selectAllExceptOther({
    required List<ProjectStageModel> stages,
    required String stageId,
    required List<String> selectedStageIds,
    required Map<String, List<String>> selectedSubStageIds,
  }) {
    final nextStages = List<String>.from(selectedStageIds);
    final nextSubs = Map<String, List<String>>.from(selectedSubStageIds);
    if (!nextStages.contains(stageId)) nextStages.add(stageId);

    ProjectStageModel? stage;
    for (final item in stages) {
      if (item.id == stageId) {
        stage = item;
        break;
      }
    }
    if (stage == null) {
      nextSubs[stageId] = List<String>.from(nextSubs[stageId] ?? const []);
      return (
        selectedStageIds: nextStages,
        selectedSubStageIds: nextSubs,
      );
    }

    final current = nextSubs[stageId] ?? const <String>[];
    final otherIds = stage.subStages
        .where((s) => s.isOther)
        .map((s) => s.id)
        .toSet();
    final keptOther = current.where(otherIds.contains);
    nextSubs[stageId] = [
      ...selectableSubStageIds(stage),
      ...keptOther,
    ];
    return (selectedStageIds: nextStages, selectedSubStageIds: nextSubs);
  }

  static List<StageRequestModel> buildStages({
    required List<String> selectedStageIds,
    required Map<String, List<String>> selectedSubStageIds,
    Map<String, List<String>> customSubStages = const {},
  }) {
    final stageIds = <String>{
      ...selectedStageIds,
      ...selectedSubStageIds.keys,
      ...customSubStages.keys,
    };
    final stages = <StageRequestModel>[];
    for (final id in stageIds) {
      if (id.isEmpty) continue;
      final subIds = selectedSubStageIds[id] ?? const [];
      final custom = customSubStages[id] ?? const [];
      if (subIds.isEmpty && custom.isEmpty) continue;
      stages.add(
        StageRequestModel(
          stageId: id,
          subStageIds: subIds,
          customSubStages: custom,
        ),
      );
    }
    return stages;
  }

  static String? validateCreate({
    required bool formValid,
    required List<StageRequestModel> stages,
    required List<String> attachments,
    required String managerName,
    required String managerPhone,
    required String managerPassword,
  }) {
    if (!formValid) return AppStrings.pleaseCompleteRequiredFields;
    if (stages.isEmpty) return AppStrings.pleaseSelectProjectStage;
    if (attachments.isEmpty) return AppStrings.pleaseAddProjectAttachment;
    if (managerName.trim().isEmpty ||
        managerPhone.trim().isEmpty ||
        managerPassword.trim().isEmpty) {
      return AppStrings.pleaseAddProjectManager;
    }
    return null;
  }

  static ProjectRequestBase buildRequest({
    required String projectName,
    required String location,
    required String startDate,
    required String endDate,
    required String price,
    required String type,
    required List<StageRequestModel> stages,
    required String managerName,
    required String managerPhone,
    required String managerPassword,
  }) {
    return ProjectRequestBase(
      projectName: projectName.trim(),
      location: location.trim(),
      startDate: startDate.trim(),
      endDate: endDate.trim(),
      price: cleanPrice(price),
      type: type,
      stages: stages,
      manager: ManagerRequestModel(
        fullName: managerName.trim(),
        phone: managerPhone.trim(),
        password: managerPassword,
      ),
    );
  }
}
