abstract class DashboardState {}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {

  final dynamic dashboard;

  DashboardLoaded({required this.dashboard});

}

class DashboardError extends DashboardState {

  final String message;

  DashboardError(this.message);

}