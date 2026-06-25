part of 'navbar_bloc.dart';

  class NavbarState extends Equatable {
  const NavbarState({this.selectedItem = 0, this.navbarItems = const []});
  final int selectedItem;
  final List<NavbarModel> navbarItems ;
  @override
  List<Object> get props => [selectedItem, navbarItems];
  NavbarState copyWith({int? selectedItem, List<NavbarModel>? navbarItems}) => NavbarState(
        selectedItem: selectedItem ?? this.selectedItem,
        navbarItems: navbarItems ?? this.navbarItems,
      );
}
 