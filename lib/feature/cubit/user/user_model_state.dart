// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_model_cubit.dart';

class UserModelState extends Equatable {
  const UserModelState({this.currentUser});
  final UserModel? currentUser;

  @override
  List<Object?> get props => [currentUser];

  UserModelState copyWith({
    UserModel? currentUser,
  }) {
    return UserModelState(
      currentUser: currentUser ?? this.currentUser,
    );
  }
}
