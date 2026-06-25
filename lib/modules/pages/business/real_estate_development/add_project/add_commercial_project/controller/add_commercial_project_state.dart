part of 'add_commercial_project_bloc.dart';

enum CommercialDateField { none, start, end }

enum CommercialDialogAction { none, showManagerLogin, showSuccess }

class AddCommercialProjectState extends Equatable {
  const AddCommercialProjectState({
    this.selectedPropertyType = '',
    this.selectedAreaType,
    this.showManagerForm = false,
    this.submitStatus = RequestStatus.init,
    this.pendingDateField = CommercialDateField.none,
    this.dialogAction = CommercialDialogAction.none,
  });

  final String selectedPropertyType;
  final String? selectedAreaType;
  final bool showManagerForm;
  final RequestStatus submitStatus;
  final CommercialDateField pendingDateField;
  final CommercialDialogAction dialogAction;

  AddCommercialProjectState copyWith({
    String? selectedPropertyType,
    String? selectedAreaType,
    bool? showManagerForm,
    RequestStatus? submitStatus,
    CommercialDateField? pendingDateField,
    CommercialDialogAction? dialogAction,
  }) =>
      AddCommercialProjectState(
        selectedPropertyType:
            selectedPropertyType ?? this.selectedPropertyType,
        selectedAreaType: selectedAreaType ?? this.selectedAreaType,
        showManagerForm: showManagerForm ?? this.showManagerForm,
        submitStatus: submitStatus ?? this.submitStatus,
        pendingDateField: pendingDateField ?? this.pendingDateField,
        dialogAction: dialogAction ?? this.dialogAction,
      );

  @override
  List<Object?> get props => [
        selectedPropertyType,
        selectedAreaType,
        showManagerForm,
        submitStatus,
        pendingDateField,
        dialogAction,
      ];
}
