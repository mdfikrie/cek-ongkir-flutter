import 'package:cek_ongkir/app/modules/home/controllers/home_controller.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Courir extends GetView<HomeController> {
  const Courir({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<Map<String, dynamic>>(
      mode: Mode.MENU,
      items: [
        {
          "code": "jne",
          "value": "Jalur Nugraha Ekakurir (JNE)",
        },
        {
          "code": "tiki",
          "value": "Titipan Kilat (TIKI)",
        },
        {
          "code": "pos",
          "value": "POS",
        },
      ],
      label: "Kurir",
      onChanged: (value) {
        if (value != null) {
          controller.kurir.value = value['code'];
        } else {
          controller.kurir.value = "";
        }
      },
      itemAsString: (item) => item!['value'],
      showClearButton: true,
    );
  }
}
