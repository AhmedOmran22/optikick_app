// 1. Updated PlayerStats model with API fetch
// 2. Updated StatsView to fetch players dynamically

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:optikick/core/api/api_consumer.dart';
import 'package:optikick/core/models/player_model.dart';
import 'package:optikick/core/keys/end_ponits.dart';
import 'package:optikick/core/services/cache_helper.dart';
import 'package:optikick/core/utils/colors.dart';
import 'package:optikick/features/stats/presentation/view/widgets/stats_info_item.dart';
import 'package:optikick/features/stats/presentation/view/player_stats.dart';

class StatsView extends StatefulWidget {
  final ApiConsumer api;
  const StatsView({super.key, required this.api});

  @override
  State<StatsView> createState() => _StatsViewState();
}

class _StatsViewState extends State<StatsView> {
  late Future<PlayersData> playerFuture;

  @override
  void initState() {
    super.initState();
    playerFuture = fetchPlayers(widget.api);
  }

  Future<PlayersData> fetchPlayers(ApiConsumer api) async {
    try {
      final response = await api.get(
        CacheHelper.getData(key: ApiKey.isDoctor)
            ? EndPoint.doctorListAllPlayers
            : EndPoint.coachListAllPlayers,
      );
      return PlayersData.fromJson(response['data']);
    } catch (e) {
      throw Exception('Failed to load players: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff102418),
            Color.fromARGB(255, 40, 59, 52),
            Color(0xff566761),
          ],
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: ColorsManager.backgroundColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: ColorsManager.realWhiteColor,
              size: 20.sp,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            "Stats",
            style: TextStyle(
              fontSize: 18.sp,
              color: ColorsManager.realWhiteColor,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        body: FutureBuilder<PlayersData>(
          future: playerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                color: Color.fromARGB(255, 97, 103, 87),
              ));
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }

            final players = snapshot.data!.players;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: players.map((player) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PlayerStats(
                                api: widget.api,
                                playerId: player.id,
                                playerName: player.name,
                              ),
                            ),
                          );
                        },
                        child: StatsInfoItem(
                          position: player.position,
                          title: player.name,
                          statusValue: player.status,
                        ),
                      ),
                      SizedBox(height: 18.h),
                    ],
                  );
                }).toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}
