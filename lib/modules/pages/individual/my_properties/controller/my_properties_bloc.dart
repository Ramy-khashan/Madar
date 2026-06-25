 import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/model/property_filter_model.dart';
import '../../../../../core/utils/constants/app_images.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../individual_home/model/portfolio_property_model.dart';

part 'my_properties_event.dart';
part 'my_properties_state.dart';

class MyPropertiesBloc extends Bloc<MyPropertiesEvent, MyPropertiesState> {
  MyPropertiesBloc() : super(MyPropertiesInitial()) {
    on<MyPropertiesLoad>(_onLoad);
    on<MyPropertiesFilterApplied>(_onFilterApplied);
  }

  static final List<PortfolioPropertyModel> _allProperties = [
      PortfolioPropertyModel(
      id: '1',
      title: 'شقة فاخرة في الملقا',
      location: 'الرياض - حي الملقا',
      imageUrl: AppImages.propertyImage,
      status: 'مؤجر',
      bath:2 ,
      bed: 3,
      area: '150 ${AppStrings.mesurement}',
      typeId: 'apartment',
      isForSale: false,
    ),
      PortfolioPropertyModel(
      id: '2',
      title: 'فيلا النرجس',
      location: 'الرياض - حي النرجس',
      imageUrl: AppImages.propertyImage,
      status: 'شاغر',
      bed: 5,
      bath: 4,
      area: '350 ${AppStrings.mesurement}',
      typeId: 'villa',
      isForSale: true,
    ),
      PortfolioPropertyModel(
      id: '3',
      title: 'شقة في حي العليا',
      location: 'الرياض - حي العليا',
      imageUrl: AppImages.propertyImage,
      status: 'مؤجر',
      bed: 2,
      bath: 1,
      area: '110 ${AppStrings.mesurement}',
      typeId: 'apartment',
      isForSale: false,
    ),
      PortfolioPropertyModel(
      id: '4',
      title: 'دور في حي الورود',
      location: 'الرياض - حي الورود',
      imageUrl: AppImages.propertyImage,
      status: 'شاغر',
      bed: 1,
      bath: 1,
      area: '50 ${AppStrings.mesurement}',
      typeId: 'floor',
      isForSale: true,
    ),
      PortfolioPropertyModel(
      id: '5',
      title: 'أرض في حي الصحافة',
      location: 'الرياض - حي الصحافة',
      imageUrl: AppImages.propertyImage,
      status: 'شاغر',
      bed: 0,
      bath: 0,
      area: '0 ${AppStrings.mesurement}',
      typeId: 'land',
      isForSale: true,
    ),
      PortfolioPropertyModel(
      id: '6',
      title: 'فيلا حي الربوة',
      location: 'الرياض - حي الربوة',
      imageUrl: AppImages.propertyImage,
      status: 'مؤجر',
      bed: 4,
      bath: 3,
      area: '300 ${AppStrings.mesurement}',
      typeId: 'villa',
      isForSale: false,
    ),
  ];

  // Keep static getter for backward compatibility with any other screen that may reference it
  static List<PortfolioPropertyModel> get myPropertiesItems => _allProperties;

  void _onLoad(MyPropertiesLoad event, Emitter<MyPropertiesState> emit) {
    emit(MyPropertiesLoaded(properties: _allProperties));
  }

  void _onFilterApplied(
    MyPropertiesFilterApplied event,
    Emitter<MyPropertiesState> emit,
  ) {
    final f = event.filter;
    final filtered = _allProperties.where((p) {
      if (p.isForSale != f.isForSale) return false;
      if (f.propertyTypeId != null && p.typeId != f.propertyTypeId) return false;
      return true;
    }).toList();
    emit(MyPropertiesLoaded(properties: filtered, filter: f));
  }
}
