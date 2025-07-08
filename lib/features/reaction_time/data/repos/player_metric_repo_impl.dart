import 'dart:developer';

import 'package:dio/dio.dart';
// import 'package:optikick/features/reaction_time/data/models/player_metric_model.dart';

import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/dio_consumer.dart';
import '../../../../core/keys/end_ponits.dart';
import '../models/graph_data_model.dart';
import 'player_metric_repo.dart';

class PlayerMetricRepoImpl implements PlayerMetricRepo {
  final ApiConsumer apiConsumer = DioConsumer(dio: Dio());

  @override
  Future<GraphDataModel> getPlayerMetric({
    required String mericType,
    String? period,
  }) async {
    String? periodString = period == null ? null : "?period=$period";
    try {
      final response = await apiConsumer
          .get("${EndPoint.metricDetails}/$mericType?$periodString");
      return GraphDataModel.fromJson(response["data"]);
    } on Exception catch (e) {
      log(e.toString());
      throw Exception('Failed to load metrics: $e');
    }
  }
}
