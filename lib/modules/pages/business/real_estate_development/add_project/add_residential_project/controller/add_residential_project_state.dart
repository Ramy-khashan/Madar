part of 'add_residential_project_bloc.dart';

enum ResidentialObscureField { password, email, phone }

enum ResidentialDateField { none, start, end }

enum ResidentialDialogAction { none, showManagerLogin, showSuccess }

class AddResidentialProjectState extends Equatable {
  const AddResidentialProjectState({
    this.selectedPropertyType = '',
    this.showManagerForm = false,
 
    this.submitStatus = RequestStatus.init,
    this.pendingDateField = ResidentialDateField.none,
    this.dialogAction = ResidentialDialogAction.none,
  });

  final String selectedPropertyType;
  final bool showManagerForm;
 
  final RequestStatus submitStatus;
  final ResidentialDateField pendingDateField;
  final ResidentialDialogAction dialogAction;

  AddResidentialProjectState copyWith({
    String? selectedPropertyType,
    bool? showManagerForm,
 
    RequestStatus? submitStatus,
    ResidentialDateField? pendingDateField,
    ResidentialDialogAction? dialogAction,
  }) =>
      AddResidentialProjectState(
        selectedPropertyType:
            selectedPropertyType ?? this.selectedPropertyType,
        showManagerForm: showManagerForm ?? this.showManagerForm,
 
        submitStatus: submitStatus ?? this.submitStatus,
        pendingDateField: pendingDateField ?? this.pendingDateField,
        dialogAction: dialogAction ?? this.dialogAction,
      );

  @override
  List<Object?> get props => [
        selectedPropertyType,
        showManagerForm,
 
        submitStatus,
        pendingDateField,
        dialogAction,
      ];
}
