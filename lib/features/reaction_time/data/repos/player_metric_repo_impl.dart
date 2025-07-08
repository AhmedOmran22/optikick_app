import 'package:dio/dio.dart';
import 'package:optikick/features/reaction_time/data/models/player_metric_model.dart';

import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/dio_consumer.dart';
import '../../../../core/keys/end_ponits.dart';
import 'player_metric_repo.dart';

class PlayerMetricRepoImpl implements PlayerMetricRepo {
  final ApiConsumer apiConsumer = DioConsumer(dio: Dio());

  @override
  Future<PlayerMetricModel> getPlayerMetric(
      {required String mericType, required int period}) async {
    try {
      final response = await apiConsumer
          .get("${EndPoint.playerMetrics}/$mericType?period=$period");
      return PlayerMetricModel.fromJson(response["data"]);
    } on Exception catch (e) {
      throw Exception('Failed to load metrics: $e');
    }
  }
}
