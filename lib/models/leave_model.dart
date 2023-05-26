import 'package:intl/intl.dart';

class Leave {
  int employeeId;
  int typeId;
  String absenceFrom;
  String absenceTo;
  String? notes;
  int leaveId;
  String employeeName;
  int statusId;
  String statusName;
  String absenceValue;
  String number;

  Leave({
    required this.employeeId,
    required this.typeId,
    required this.absenceFrom,
    required this.absenceTo,
     this.notes,
    required this.leaveId,
    required this.employeeName,
    required this.statusId,
    required this.statusName,
    required this.absenceValue,
    required this.number,
  });

  factory Leave.fromJson(Map<String, dynamic> json) =>
      Leave(
          employeeId: json['id'],
          typeId: json['typeId'],
          absenceFrom:DateFormat('MMM d, yyyy').format(DateTime.parse(json['absenceFrom']).toLocal()),
          absenceTo:DateFormat('MMM d, yyyy').format(DateTime.parse(json['absenceTo']).toLocal()),
          notes: json['notes'],
          leaveId: json['id'],
          employeeName: json['employeeName'],
          statusId: json['statusId'],
          statusName: json['statusName'],
          absenceValue: json['absenceValue'],
          number: json['number']
      );

}