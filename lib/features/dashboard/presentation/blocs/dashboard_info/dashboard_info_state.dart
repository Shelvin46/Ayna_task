part of 'dashboard_info_bloc.dart';

///[DashboardInfoState] is a sealed class that extends [Equatable] to make the [DashboardInfoState] object comparable.
///It has four states:
///1. [DashboardInfoInitial] is the initial state of the [DashboardInfoBloc].
///2. [DashboardInfoLoading] is the state when the user's name is being fetched from Firestore.
///3. [DashboardInfoLoaded] is the state when the user's name is fetched successfully from Firestore.
///4. [DashboardInfoError] is the state when an error occurs while fetching the user's name from Firestore.
///5. [DashboardInfoLogout] is the state when the user logs out.

sealed class DashboardInfoState extends Equatable {
  const DashboardInfoState();

  @override
  List<Object> get props => [];
}

final class DashboardInfoInitial extends DashboardInfoState {}

final class DashboardInfoLoading extends DashboardInfoState {}

final class DashboardInfoLoaded extends DashboardInfoState {
  final String userName;

  const DashboardInfoLoaded(this.userName);

  @override
  List<Object> get props => [userName];
}

final class DashboardInfoError extends DashboardInfoState {
  final String message;

  const DashboardInfoError(this.message);

  @override
  List<Object> get props => [message];
}

final class DashboardInfoLogout extends DashboardInfoState {}
