class Promotion {
  final String id;
  final String? name;
  final double? amount;
  final DateTime? startTime;
  final DateTime? endTime;
  final String? type;
  final String? storeId;

  Promotion(
      {required this.id,
      required this.name,
      required this.amount,
      required this.startTime,
      required this.endTime,
      required this.type,
      required this.storeId});
}
