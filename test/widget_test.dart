import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  Uri url = Uri.parse("https://api.rajaongkir.com/starter/province");
  final response = await http.get(
    url,
    headers: {
      "key": "1455b7037a7e7e8ed58dcb0656a99544",
    },
  );
  final provinsi = json.decode(response.body)['rajaongkir']['results'];
  print(provinsi);
}
