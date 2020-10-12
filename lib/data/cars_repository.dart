import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'car_company.dart';
import 'car_model.dart';

abstract class CarsRepository {
  Future<List<CarModel>> fetchCarModel(String model_id);

  Future<List<CarCompany>> fetchCarCompany();
}

class CarsRepo implements CarsRepository {
  Future<List<CarModel>> fetchCarModel(String model_id) async {
    print(model_id);
    String url =
        'http://rootless.aaratechnologies.in/user/objects/modelapi.php';
    final http.Response response = await http.get("$url");
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      String str;
      List<CarModel> listing = body['data']
          .map<CarModel>((dynamic item) => CarModel.fromJson(item))
          .toList();
      return listing;
    } else {
      throw Exception('Failed to get Data.');
    }
  }

  Future<List<CarCompany>> fetchCarCompany() async {
    String url =
        'http://rootless.aaratechnologies.in/user/user/object/vehicleapi.php';
    final http.Response response = await http.get("$url");
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      List<CarCompany> listing = body
          .map<CarCompany>((dynamic item) => CarCompany.fromJson(item))
          .toList();
      return listing;
    } else {
      throw Exception('Failed to get Data.');
    }
  }
}
