part of '../add_property_bloc.dart';

mixin AddPropertyControllersMixin on Bloc<AddPropertyEvent, AddPropertyState> {
  final TextEditingController buildingNumberController =
      TextEditingController();
  final TextEditingController streetWidthController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController deedNumberController = TextEditingController();
  final TextEditingController customTypeNameController =
      TextEditingController();
  final TextEditingController dateController = TextEditingController();
  DateTime? deedPickedAt;
  final TextEditingController areaController = TextEditingController();
  final TextEditingController apartmentNumberController =
      TextEditingController();
  final TextEditingController developerNameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController portfolioNameController = TextEditingController();
  final TextEditingController locationSearchController =
      TextEditingController();

  final Map<String, TextEditingController> _detailControllers = {};

  TextEditingController detailController(String key) =>
      _detailControllers.putIfAbsent(key, TextEditingController.new);

  Map<String, String> get detailControllerValues => {
    for (final entry in _detailControllers.entries)
      if (entry.value.text.trim().isNotEmpty)
        entry.key: entry.value.text.trim(),
  };

  AddPropertyModel modelWithControllerValues() {
    final details = Map<String, dynamic>.from(state.model.typeDetails)
      ..addAll(detailControllerValues);

    return state.model.copyWith(
      typeDetails: details,
      buildingNumber: buildingNumberController.text.trim(),
      street: streetController.text.trim(),
      deedNumber: deedNumberController.text.trim(),
      customTypeName: customTypeNameController.text.trim(),
      date: dateController.text.trim(),
      area: areaController.text.trim(),
      streetWidth: streetWidthController.text.trim(),
      apartmentNumber: apartmentNumberController.text.trim(),
      developerName: developerNameController.text.trim(),
      price: priceController.text.trim(),
      title: titleController.text.trim(),
      description: descriptionController.text.trim(),
      portfolioFolderName: portfolioNameController.text.trim(),
    );
  }

  AddPropertyStep stepForField(String key) {
    switch (key) {
      case AddPropertyField.propertyType:
        return AddPropertyStep.type;
      case AddPropertyField.rentalPeriod:
        return AddPropertyStep.period;
      case AddPropertyField.location:
      case AddPropertyField.deedType:
      case AddPropertyField.deedNumber:
      case AddPropertyField.deedDate:
      case AddPropertyField.customTypeName:
      case AddPropertyField.ownershipDocument:
        return AddPropertyStep.location;
      case AddPropertyField.images:
        return AddPropertyStep.images;
      case AddPropertyField.price:
      case AddPropertyField.title:
        return AddPropertyStep.review;
      default:
        return AddPropertyStep.details;
    }
  }

  void disposeControllers() {
    buildingNumberController.dispose();
    streetController.dispose();
    deedNumberController.dispose();
    customTypeNameController.dispose();
    dateController.dispose();
    areaController.dispose();
    apartmentNumberController.dispose();
    developerNameController.dispose();
    priceController.dispose();
    titleController.dispose();
    portfolioNameController.dispose();
    locationSearchController.dispose();
    for (final controller in _detailControllers.values) {
      controller.dispose();
    }
  }
}
