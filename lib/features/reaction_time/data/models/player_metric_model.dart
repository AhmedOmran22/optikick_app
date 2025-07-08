import 'graph_data_model.dart';
import 'player_model.dart';

class PlayerMetricModel {
  final PlayerModel player;
  final String metricType;
  final String period;
  final List<GraphDataModel> graphData;
  final List<String> highlights;
  final double trend;

  PlayerMetricModel({
    required this.player,
    required this.metricType,
    required this.period,
    required this.graphData,
    required this.highlights,
    required this.trend,
  });

  factory PlayerMetricModel.fromJson(Map<String, dynamic> json) {
    return PlayerMetricModel(
      player: PlayerModel.fromJson(json['player']),
      metricType: json['metric_type'],
      period: json['period'],
      graphData: (json['graph_data'] as List)
          .map((e) => GraphDataModel.fromJson(e))
          .toList(),
      highlights: List<String>.from(json['highlights']),
      trend: (json['trend'] as num).toDouble(),
    );
  }
}
