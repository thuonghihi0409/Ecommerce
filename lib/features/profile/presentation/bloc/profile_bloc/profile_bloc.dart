import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:thuongmaidientu/features/profile/domain/entities/profile.dart';
import 'package:thuongmaidientu/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:thuongmaidientu/shared/utils/helper.dart';
import 'package:thuongmaidientu/shared/utils/parse_error_model.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  GetProfileUsecase getProfileUsecase;
  ProfileBloc(this.getProfileUsecase) : super(ProfileState.empty()) {
    on<GetProfile>(getProfile);
  }

  void getProfile(GetProfile event, Emitter<ProfileState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      final profile = await getProfileUsecase.call(email: event.email);
      emit(state.copyWith(isLoading: false, profile: profile));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      log("error ====${ParseError.fromJson(e).message}");
      Helper.showToastBottom(message: ParseError.fromJson(e).message);
    }
  }
}
