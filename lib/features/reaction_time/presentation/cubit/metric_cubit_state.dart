import '../../data/models/graph_data_model.dart';
// import '../../data/models/player_metric_model.dart';

abstract class MetricCubitState {}

class MetricCubitInitial extends MetricCubitState {}

class MetricCubitLoading extends MetricCubitState {}

class MetricCubitLoaded extends MetricCubitState {
  final GraphDataModel playerMetricModel;
  MetricCubitLoaded({required this.playerMetricModel});
}

class MetricCubitError extends MetricCubitState {
  final String errorMessage;
  MetricCubitError({required this.errorMessage});
}
