part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final bool isLoading;
  final ProfileEntity? profile;
  final List<AddressEntity>? address;
  final List<ProvinceEntity>? provinces;
  final List<WardEntity>? wards;
  const ProfileState(
      {this.isLoading = false,
      this.profile,
      this.address,
      this.provinces,
      this.wards});
  factory ProfileState.empty() {
    return const ProfileState(
      isLoading: false,
      profile: null,
    );
  }

  ProfileState copyWith(
      {bool? isLoading,
      ProfileEntity? profile,
      List<AddressEntity>? address,
      List<ProvinceEntity>? provinces,
      List<WardEntity>? wards}) {
    return ProfileState(
        isLoading: isLoading ?? this.isLoading,
        profile: profile ?? this.profile,
        provinces: provinces ?? this.provinces,
        address: address ?? this.address,
        wards: wards ?? this.wards);
  }

  @override
  List<Object?> get props => [isLoading, profile, address, provinces, wards];
}
