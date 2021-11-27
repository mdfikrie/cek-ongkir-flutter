import 'package:cek_ongkir/app/modules/home/controllers/home_controller.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Berat extends GetView<HomeController> {
  const Berat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller.berat,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: "Berat",
              border: OutlineInputBorder(),
            ),
            onChanged: (value) => controller.ubahBerat(value),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Container(
          width: 150,
          child: DropdownSearch<String>(
            mode: Mode.BOTTOM_SHEET,
            items: [
              "ton",
              "kwintal",
              "ons",
              "kg",
              "gram",
            ],
            label: "Satuan",
            onChanged: (value) {
              if (value != "") {
                controller.konversi(value!);
              }
            },
            selectedItem: "gram",
          ),
        ),
      ],
    );
  }
}
