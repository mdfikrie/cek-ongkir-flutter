import 'dart:convert';
import 'package:cek_ongkir/app/modules/home/controllers/home_controller.dart';
import 'package:cek_ongkir/app/modules/home/kota_model.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class KotaSearch extends GetView<HomeController> {
  final provId;
  final type;
  const KotaSearch({
    Key? key,
    required this.provId,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(provId);
    return DropdownSearch<Kota>(
      label: type == "asal" ? "Kota Asal" : "Kota Tujuan",
      onFind: (String? filter) async {
        Uri url = Uri.parse(
            "https://api.rajaongkir.com/starter/city?province=$provId");
        final response = await http.get(
          url,
          headers: {
            "key": "1455b7037a7e7e8ed58dcb0656a99544",
          },
        );
        var data = json.decode(response.body) as Map<String, dynamic>;

        var listAllKota = data['rajaongkir']['results'];

        var models = Kota.fromJsonList(listAllKota);
        return models;
      },
      showSearchBox: true,
      popupItemBuilder: (context, item, isSelected) => Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Text(
          "${item.type} ${item.cityName}",
        ),
      ),
      showClearButton: true,
      onChanged: (value) {
        if (value != null) {
          if (type == "asal") {
            controller.idKotaAsal.value = int.parse(value.cityId!);
          } else {
            controller.idKotaTujuan.value = int.parse(value.cityId!);
          }
        } else {
          print("Tidak ada kota yang dipilih");
        }
      },
      itemAsString: (item) => item!.cityName!,
    );
  }
}
