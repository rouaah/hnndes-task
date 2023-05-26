import 'package:hnndestask/models/company_model.dart';
import 'package:hnndestask/models/department_model.dart';
import 'package:hnndestask/models/employee_model.dart';

class UserModel{
  String? id;
  String? username;

  List<Company>? companys;
  List<Department>? departments;
  Employee? employee;

  UserModel(
      {this.id,
        this.username,
        this.companys,
        this.departments,
        this.employee});

  factory UserModel.fromJson(Map<String, dynamic> json) =>UserModel(
    id: json['id'] ,
      username: json['username'],
    companys: List<Company>.from(json['companys'].map((x)=> Company.fromJson(x))),
    departments: List<Department>.from(json['departments'].map((x)=> Department.fromJson(x))),
    employee: Employee.fromJson(json['employee']),
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullName'] = this.username;
    data['companys'] = List<Company>.from(this.companys!.map((x) => x.toJson()));
    data['departments'] = List<Department>.from(this.departments!.map((x) => x.toJson()));
    data['employee']=this.employee;
    return data;
  }

}