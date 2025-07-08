import 'package:optikick/features/reaction_time/presentation/data/models/player_metric_model.dart';

abstract class PlayerMetricRepo {
  Future<PlayerMetricModel> getPlayerMetric({
    required String mericType,
    required int period,
  });
}
