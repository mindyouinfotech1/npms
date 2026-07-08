class MissedPatrolModel {

  final String stationId;
  final String stationName;

  final String checkpointId;
  final String checkpointName;

  final String qrId;

  final String priority;

  final String officerId;
  final String officerName;

  MissedPatrolModel({
    required this.stationId,
    required this.stationName,
    required this.checkpointId,
    required this.checkpointName,
    required this.qrId,
    required this.priority,
    required this.officerId,
    required this.officerName,
  });
}