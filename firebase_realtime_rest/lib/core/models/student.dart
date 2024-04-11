class Student {
  String key;
  String name;
  String number;

  Student(this.key, this.name, this.number);

  Student.fromJson(Map<String, dynamic> json)
      : key = json['key'] ?? "",
        name = json['name'] ?? "",
        number = json['number'] ?? "";

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['name'] = name;
    data['number'] = number;
    return data;
  }
}
