import 'package:bloc/bloc.dart';
import 'package:ct_social/feature/model/user_model.dart';
import 'package:equatable/equatable.dart';

part 'user_model_state.dart';

class UserModelCubit extends Cubit<UserModelState> {
  UserModelCubit() : super(const UserModelState());

  void setUser(UserModel user) {
    return emit(state.copyWith(currentUser: user));
  }
}
