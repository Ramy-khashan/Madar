part of 'navbar_bloc.dart';

sealed class NavbarEvent extends Equatable {
  const NavbarEvent();

  @override
  List<Object> get props => [];
}

class NavbarItemSelected extends NavbarEvent {
  final int selectedItem;

  const NavbarItemSelected(this.selectedItem);

  @override
  List<Object> get props => [selectedItem];
}

class NavBarInitList extends NavbarEvent {
  const NavBarInitList();
}
