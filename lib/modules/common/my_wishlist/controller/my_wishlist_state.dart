part of 'my_wishlist_bloc.dart';

  class MyWishlistState extends Equatable {
    final String errorMsg;
    final RequestStatus propertiesStatus;
    final List<PropertiesItemModel> savedProperties;
    
  const MyWishlistState(
      {this.errorMsg = '',
      this.propertiesStatus = RequestStatus.init,
      this.savedProperties = const []});
  
  @override
  List<Object> get props => [errorMsg, propertiesStatus, savedProperties];
MyWishlistState copyWith({
    String? errorMsg,
    RequestStatus? propertiesStatus,
    List<PropertiesItemModel>? savedProperties,
  }) {
    return MyWishlistState(
      errorMsg: errorMsg ?? this.errorMsg,
      propertiesStatus: propertiesStatus ?? this.propertiesStatus,
      savedProperties: savedProperties ?? this.savedProperties,
    );
  }

}
 