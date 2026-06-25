part of 'add_auction_property_bloc.dart';

class AddAuctionPropertyState extends Equatable {
  const AddAuctionPropertyState({
    this.form = const AddAuctionPropertyFormModel(),
    this.submitStatus = RequestStatus.init,
  });

  final AddAuctionPropertyFormModel form;
  final RequestStatus submitStatus;

  @override
  List<Object?> get props => [form, submitStatus];

  AddAuctionPropertyState copyWith({
    AddAuctionPropertyFormModel? form,
    RequestStatus? submitStatus,
  }) {
    return AddAuctionPropertyState(
      form: form ?? this.form,
      submitStatus: submitStatus ?? this.submitStatus,
    );
  }
}
