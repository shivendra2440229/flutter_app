class CarModel{
  CarModel({this.id, this.name,this.companyId});
  final String id;
  final String companyId;
  final String name;
  factory CarModel.fromJson(Map<String, dynamic> parsedJson) {
    return CarModel(
        id: parsedJson['model_id'],
        name:parsedJson['model'],
        companyId: parsedJson['car_id']
    );
  }
}