import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/repository/apis/property_file_apis.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/common_fun.dart';
import '../../../individual/property_details/model/property_details_model.dart';
import '../model/property_file_model.dart';

part 'property_file_event.dart';
part 'property_file_state.dart';

class PropertyFileBloc extends Bloc<PropertyFileEvent, PropertyFileState> {
  PropertyFileBloc() : super(const PropertyFileState()) {
    on<PropertyFileLoad>(_onLoad);
    on<PropertyFileToggleBookmark>(_onToggleBookmark);
    on<PropertyFileDeleteProperty>(_onDeleteProperty);
    on<PropertyFileSaveChanges>(_onSaveChanges);
    on<PropertyFileExpenseAdded>(_onExpenseAdded);
    on<PropertyFileExpenseRemoved>(_onExpenseRemoved);
    on<PropertyFileExpenseFilesPicked>(_onExpenseFilesPicked);
  }

  String _propertyId = '';
  final TextEditingController titleController = TextEditingController();
  final TextEditingController projectNameController = TextEditingController();
  final TextEditingController expenseDescController = TextEditingController();
  final TextEditingController expenseAmountController = TextEditingController();

  static PropertyFileBloc get(BuildContext context) =>
      context.read<PropertyFileBloc>();

  Future<void> _onLoad(
    PropertyFileLoad event,
    Emitter<PropertyFileState> emit,
  ) async {
    if (event.propertyId.isNotEmpty) {
      _propertyId = event.propertyId;
    }
    emit(const PropertyFileState(status: RequestStatus.loading));
    if (_propertyId.isEmpty) {
      emit(
        state.copyWith(
          status: RequestStatus.failed,
          errorMsg: AppStrings.somethingWentWrong,
        ),
      );
      return;
    }

    final result = await PropertyFileApis.getProperty(_propertyId);
    if (isClosed) return;
    result.fold(
      (error) {
        emit(state.copyWith(status: RequestStatus.failed, errorMsg: error));
      },
      (details) {
        titleController.text = details.title ?? '';
        projectNameController.text = details.projectName ?? '';
        final mapped = PropertyFileModel.fromDetails(details);
        emit(
          state.copyWith(
            details: details,
            property: mapped,
            expenses: UnitModel.fromDetails(details).expenses,
            status: RequestStatus.success,
          ),
        );
      },
    );
  }

  void _onToggleBookmark(
    PropertyFileToggleBookmark event,
    Emitter<PropertyFileState> emit,
  ) {
    final p = state.property;
    if (p == null) return;
    emit(state.copyWith(property: p.copyWith(isBookmarked: !p.isBookmarked)));
  }

  Future<void> _onDeleteProperty(
    PropertyFileDeleteProperty event,
    Emitter<PropertyFileState> emit,
  ) async {
    if (_propertyId.isEmpty) return;
    final result = await PropertyFileApis.deleteProperty(_propertyId);
    result.fold(
      (error) => AppToast(error, isError: true),
      (_) => emit(state.copyWith(isDeleted: true)),
    );
  }

  Future<void> _onSaveChanges(
    PropertyFileSaveChanges event,
    Emitter<PropertyFileState> emit,
  ) async {
    if (_propertyId.isEmpty) return;
    emit(state.copyWith(saveStatus: RequestStatus.loading));
    final result = await PropertyFileApis.updateProperty(
      propertyId: _propertyId,
      title: titleController.text.trim(),
      projectName: projectNameController.text.trim(),
    );
    if (isClosed) return;

    await result.fold(
      (error) async {
        AppToast(error, isError: true);
        emit(state.copyWith(saveStatus: RequestStatus.failed));
      },
      (details) async {
        var nextDetails = details;
        final shouldSaveExpenses =
            state.expenses.any((e) => !e.isRemote) ||
            state.expenseFiles.isNotEmpty;
        if (shouldSaveExpenses) {
          final expenseResult = await PropertyFileApis.saveExpenses(
            propertyId: _propertyId,
            expenses: state.expenses.where((e) => !e.isRemote).toList(),
            filePaths: state.expenseFiles,
          );
          await expenseResult.fold(
            (error) async => AppToast(error, isError: true),
            (_) async {
              final reload = await PropertyFileApis.getProperty(_propertyId);
              reload.fold((_) {}, (fresh) => nextDetails = fresh);
            },
          );
        }
        if ((nextDetails.media == null || nextDetails.media!.isEmpty) &&
            state.details != null) {
          nextDetails.media = state.details!.media;
        }
        nextDetails.title = titleController.text.trim();
        nextDetails.projectName = projectNameController.text.trim();
        final mapped = PropertyFileModel.fromDetails(nextDetails);
        emit(
          state.copyWith(
            details: nextDetails,
            property: mapped,
            expenses: UnitModel.fromDetails(nextDetails).expenses,
            saveStatus: RequestStatus.success,
            expenseFiles: const [],
          ),
        );
        AppToast(AppStrings.propertyUpdated);
      },
    );
  }

  void _onExpenseAdded(
    PropertyFileExpenseAdded event,
    Emitter<PropertyFileState> emit,
  ) {
    final desc = expenseDescController.text.trim();
    final amt = parsePrice(expenseAmountController.text)?.toDouble() ?? 0;
    if (desc.isEmpty || amt <= 0) return;
    emit(
      state.copyWith(
        expenses: [
          ...state.expenses,
          UnitExpenseModel(description: desc, amount: amt,),
        ],
      ),
    );
    expenseDescController.clear();
    expenseAmountController.clear();
  }

  void _onExpenseRemoved(
    PropertyFileExpenseRemoved event,
    Emitter<PropertyFileState> emit,
  ) {
    final updated = List<UnitExpenseModel>.from(state.expenses)
      ..removeAt(event.index);
    emit(state.copyWith(expenses: updated));
  }

  void _onExpenseFilesPicked(
    PropertyFileExpenseFilesPicked event,
    Emitter<PropertyFileState> emit,
  ) {
    emit(state.copyWith(expenseFiles: [...state.expenseFiles, ...event.paths]));
  }

  @override
  Future<void> close() {
    titleController.dispose();
    projectNameController.dispose();
    expenseDescController.dispose();
    expenseAmountController.dispose();
    return super.close();
  }
}
