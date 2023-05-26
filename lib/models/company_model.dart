class Company{
  int companyId;
  String companyName;

  Company({required this.companyId,required this.companyName});

  factory Company.fromJson(Map<String, dynamic> json) =>Company(companyId:json['id'] , companyName: json['companyName']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.companyId;
    data['companyName'] = this.companyName;
    return data;
  }
}