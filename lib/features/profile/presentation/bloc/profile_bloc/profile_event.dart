part of 'profile_bloc.dart';

class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class GetProfile extends ProfileEvent {
  final String email;
  final Function? onSuccess;
  const GetProfile({required this.email, this.onSuccess});
}

class GetAddress extends ProfileEvent {
  final String id;
  const GetAddress({required this.id});
}

class GetProvinces extends ProfileEvent {
  const GetProvinces();
}

class GetWards extends ProfileEvent {
  final String id;
  const GetWards({required this.id});
}

class AddAddress extends ProfileEvent {
  final String id;
  final AddressEntity addressEntity;
  final Function? onSuccess;
  const AddAddress(
      {required this.id, required this.addressEntity, this.onSuccess});
}
