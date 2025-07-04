part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final bool isLoading;
  final ProfileEntity? profile;
  const ProfileState({this.isLoading = false, this.profile});
  factory ProfileState.empty() {
    return const ProfileState(isLoading: false, profile: null);
  }

  ProfileState copyWith({bool? isLoading, ProfileEntity? profile}) {
    return ProfileState(
        isLoading: isLoading ?? this.isLoading,
        profile: profile ?? this.profile);
  }

  @override
  List<Object?> get props => [isLoading, profile];
}
