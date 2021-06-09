import 'dart:convert';
import 'package:http/http.dart' as http;

class DataBaseHelper {
  //Funcion para agregar un producto a la BD
  Future<http.Response> addDataProducto(String nameController,
      String quantityController, String priceController) async {
      var url = Uri.parse('http://192.168.0.127:8686/addUser');

    Map data = {
      'name': '$nameController',
      'email': '$quantityController',
      'address': '$priceController',
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);
    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

  //function for update or put
  Future<http.Response> editarProduct(String id, String nameController,
      String quantityController, String priceController) async {
    int a = int.parse(id);
    print(a);
    var url = Uri.parse('http://192.168.0.127:8686/update');

    Map data = {
      'id': '$a',
      'name': '$nameController',
      'email': '$quantityController',
      'address': '$priceController',
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.put(url,
        headers: {"Content-Type": "application/json"}, body: body);
    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }
  Future<http.Response> removeRegister(String id) async {
    int a = int.parse(id);
    print(a);
    var url = Uri.parse('http://192.168.0.127:8686/delete/$a');

    var response =
        await http.delete(url, headers: {"Content-Type": "application/json"});
    print("${response.statusCode}");
    return response;
  }
}
