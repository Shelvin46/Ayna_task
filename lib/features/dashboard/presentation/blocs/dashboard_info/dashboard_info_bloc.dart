import 'package:ayna_task/features/authentication/domain/entities/user_entity.dart';
import 'package:ayna_task/features/dashboard/domain/usecases/dashboard_usecases.dart';
import 'package:ayna_task/service_locator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'dashboard_info_event.dart';
part 'dashboard_info_state.dart';

/// [DashboardInfoBloc] is a [Bloc] that takes [DashboardInfoEvent] as an input and emits [DashboardInfoState] as an output.
/// It is used to manage the state of the dashboard screen.
/// It has one event:
/// 1. [DashboardInfoFetch] is the event that is used to fetch the user's name from Firestore.
/// It has three states:
/// 1. [DashboardInfoInitial] is the initial state of the bloc.
/// 2. [DashboardInfoLoading] is the state when the bloc is loading the user's name.
/// 3. [DashboardInfoLoaded] is the state when the bloc has successfully loaded the user's name.
/// 4. [DashboardInfoError] is the state when the bloc has failed to load the user's name.
class DashboardInfoBloc extends Bloc<DashboardInfoEvent, DashboardInfoState> {
  DashboardInfoBloc() : super(DashboardInfoInitial()) {
    on<DashboardInfoFetch>((event, emit) async {
      emit(DashboardInfoLoading());
      // Call the use case to get the user's name
      final result = await locator<DashboardUseCases>().executeGetDashboardInfo(
        event.userEntity,
      );
      // Emit the state based on the result
      result.fold(
        (failure) => emit(DashboardInfoError(failure.message)),
        (userName) => emit(DashboardInfoLoaded(userName)),
      );
    });
  }
}
