import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/features/user/UserApp/model_complaint.dart';
import 'package:flutter_application_1/features/user/UserApp/user_home_model.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class SignInSuccess extends UserState {}

class SignInLoading extends UserState {}

class SignInFailure extends UserState {
  final String message;

  const SignInFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class SignUpLoading extends UserState {}

class SignUpSuccess extends UserState {}

class SigUpFailure extends UserState {
  final String message;

  const SigUpFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class GetUserLoading extends UserState {}

class GetUserSuccess extends UserState {}

class GetUserFailure extends UserState {
  final String message;

  const GetUserFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class SignIn1Success extends UserState {}

class SignIn1Loading extends UserState {}

class SignIn1Failure extends UserState {
  final String message;

  const SignIn1Failure({required this.message});

  @override
  List<Object?> get props => [message];
}

class OtpSuccess extends UserState {}

class OtpLoading extends UserState {}

class OtpFailure extends UserState {
  final String message;

  const OtpFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

// Adding the UserHomeState cases
class UserHomeInitial extends UserState {}

class UserHomeLoading extends UserState {
}
class UserHomeNot extends UserState {
}
class UserHomeLoaded extends UserState {
  final UserHome userHome;

  const UserHomeLoaded(this.userHome);

  @override
  List<Object?> get props => [userHome];
}

class UserHomeError extends UserState {
  final String error;

  const UserHomeError(this.error);

  @override
  List<Object?> get props => [error];
}

class RequestNotificationInitial extends UserState {}

class RequestNotificationLoading extends UserState {}

class RequestNotificationLoaded extends UserState {
  final Map<String, dynamic> data;
  const RequestNotificationLoaded(this.data);
}
class RequestNotificationLoadedNot extends UserState {
  final Map<String, dynamic> data;
  const RequestNotificationLoadedNot(this.data);
}

class RequestNotificationError extends UserState {
  final String message;
  const RequestNotificationError(this.message);
}


class InfoInitial extends UserState {}

class InfoLoading extends UserState {}

class InfoLoaded extends UserState {
  final Map<String, dynamic> data;
  InfoLoaded(this.data);
}
class InfoSupport extends UserState {
  final String message;
  InfoSupport(this.message);
}
class InfoError extends UserState {
  final String message;
  InfoError(this.message);
}
class HomeInitial extends UserState {}

class HomeLoading extends UserState {}

class HomeLoaded extends UserState {
  final Map<String, dynamic> user;
  HomeLoaded(this.user);
}

class HomeError extends UserState {
  final String message;
  HomeError(this.message);
}

class ComplaintsInitial extends UserState {}

class ComplaintsSuccess extends UserState {
  final String message;
  ComplaintsSuccess(this.message);
}

class ComplaintsLoading extends UserState {}

class ComplaintsLoaded extends UserState {
  final List<Complaint> complaints;

  ComplaintsLoaded(this.complaints);

  @override
  List<Object?> get props => [complaints];
}

class ComplaintsError extends UserState {
  final String message;

  ComplaintsError(this.message);

  @override
  List<Object?> get props => [message];
}