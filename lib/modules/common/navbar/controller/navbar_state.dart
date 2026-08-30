part of 'navbar_bloc.dart';

class NavbarState extends Equatable {
  const NavbarState({
    this.selectedItem = 0,
    this.navbarItems = const [],
    this.refreshId = 0,
  });

  final int selectedItem;
  final List<NavbarModel> navbarItems;
  final int refreshId;

  @override
  List<Object> get props => [selectedItem, navbarItems, refreshId];

  NavbarState copyWith({
    int? selectedItem,
    List<NavbarModel>? navbarItems,
    int? refreshId,
  }) => NavbarState(
    selectedItem: selectedItem ?? this.selectedItem,
    navbarItems: navbarItems ?? this.navbarItems,
    refreshId: refreshId ?? this.refreshId,
  );
}
 