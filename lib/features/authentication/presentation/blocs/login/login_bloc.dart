import 'package:ayna_task/features/authentication/domain/entities/user_entity.dart';
import 'package:ayna_task/features/authentication/domain/usecases/login_usecase.dart';
import 'package:ayna_task/service_locator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

///[LoginBloc] is a [Bloc] that handles the login event
///It extends [Bloc] and takes [LoginEvent] and [LoginState]
///It has a constructor that takes [LoginInitial] state
///It has a method that listens to [LoginButtonPressed] event
///and emits [LoginLoading] state
///It then creates a [UserEntity] object and calls [LoginUsecases] to execute login
///It then emits [LoginFailure] or [LoginSuccess] state based on the result
///of the login process

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());
      final userEntity = UserEntity(
        email: event.email,
        password: event.password,
      );

      final result = await locator<LoginUsecases>().executeLogin(userEntity);

      result.fold((value) {
        return emit(LoginFailure(message: value.message));
      }, (value) {
        return emit(LoginSuccess(user: value, token: value.token));
      });
    });
  }
}
