
class GraphDataModel {
  final String date;
  final double value;

  GraphDataModel({
    required this.date,
    required this.value,
  });

  factory GraphDataModel.fromJson(Map<String, dynamic> json) {
    return GraphDataModel(
      date: json['date'],
      value: double.parse(json['value']),
    );
  }
}
