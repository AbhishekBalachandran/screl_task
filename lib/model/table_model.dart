import 'package:hive/hive.dart';
part 'table_model.g.dart';

@HiveType(typeId: 1)
class TableModal {
  @HiveField(0)
  String table;
  @HiveField(1)
  int capacity;
  @HiveField(2)
  bool isAvailable;
  @HiveField(3)
  List<Status> status;

  TableModal({
    required this.table,
    required this.capacity,
    required this.isAvailable,
    required this.status,
  });

  factory TableModal.fromJson(Map<String, dynamic> json) => TableModal(
        table: json["table"],
        capacity: json["capacity"],
        isAvailable: json["is_available"],
        status:
            List<Status>.from(json["status"].map((x) => Status.fromJson(x))),
      );
}

@HiveType(typeId: 2)
class Status {
  @HiveField(0)
  int timestamp;
  @HiveField(1)
  String status;

  Status({
    required this.timestamp,
    required this.status,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        timestamp: json["timestamp"],
        status: json["status"],
      );
}
