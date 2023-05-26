import 'package:hnndestask/models/company_model.dart';
import 'package:hnndestask/models/department_model.dart';

class Employee{
  int employeeId;
  String fullName;
  Company company;
  Department department;

Employee({
  required this.employeeId,
  required this.fullName,
  required this.company,
  required this.department,
});

  factory Employee.fromJson(Map<String, dynamic> json) =>Employee(
      employeeId:json['id'] ,
      fullName: json['fullName'],
      company:  Company.fromJson(json['company']),
      department: Department.fromJson(json['department']),
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.employeeId;
    data['fullName'] = this.fullName;
    data['company'] = this.company.toJson();
    data['department'] = this.department.toJson();
    return data;
  }

}