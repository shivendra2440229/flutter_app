class CarCompany {
  CarCompany({this.id, this.company});
  final String id;
  final String company;
  factory CarCompany.fromJson(Map<String, dynamic> parsedJson) {
    return CarCompany(
        id: parsedJson['car_id'],
        company: parsedJson['cars']
    );
  }
}