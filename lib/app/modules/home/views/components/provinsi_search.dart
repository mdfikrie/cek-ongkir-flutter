import 'dart:convert';
import 'package:cek_ongkir/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:cek_ongkir/app/modules/home/provinsi_model.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class ProvinsiSearch extends GetView<HomeController> {
  final type;
  const ProvinsiSearch({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<Provinsi>(
      label: type == "asal" ? "Provinsi Asal" : "Provinsi Tujuan",
      onFind: (String? filter) async {
        Uri url = Uri.parse("https://api.rajaongkir.com/starter/province");
        final response = await http.get(
          url,
          headers: {
            "key": "1455b7037a7e7e8ed58dcb0656a99544",
          },
        );
        var data = json.decode(response.body) as Map<String, dynamic>;

        var listAllProvince = data['rajaongkir']['results'];

        var models = Provinsi.fromJsonList(listAllProvince);
        return models;
      },
      showSearchBox: true,
      popupItemBuilder: (context, item, isSelected) => Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Text(
          "${item.province}",
        ),
      ),
      showClearButton: true,
      onChanged: (value) {
        if (value != null) {
          if (type == "asal") {
            controller.hiddenKotaAsal.value = false;
            controller.provIdAsal.value = int.parse(value.provinceId!);
            print("privinsi asal");
          } else {
            controller.hiddenKotaTujuan.value = false;
            controller.provIdTujuan.value = int.parse(value.provinceId!);
            print("privinsi tujuan");
          }
        } else {
          if (type == "asal") {
            controller.provIdAsal.value = 0;
            controller.hiddenKotaAsal.value = true;
          } else {
            controller.provIdTujuan.value = 0;
            controller.hiddenKotaTujuan.value = true;
          }
          print("Tidak ada provinsi yang dipilih");
        }
      },
      itemAsString: (item) => item!.province!,
    );
  }
}
