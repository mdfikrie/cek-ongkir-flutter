import 'dart:convert';

import 'package:cek_ongkir/app/modules/home/cost_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  var hiddenKotaAsal = true.obs;
  RxInt provIdAsal = 0.obs;

  var hiddenKotaTujuan = true.obs;
  RxInt provIdTujuan = 0.obs;

  RxInt idKotaAsal = 0.obs;
  RxInt idKotaTujuan = 0.obs;

  TextEditingController berat = TextEditingController();
  var satuan = "gram".obs;

  var showButton = false.obs;

  var kurir = "".obs;

  var beratKonversi = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    berat = TextEditingController(text: "0.0");
  }

  void ubahBerat(String value) {
    // print(satuan.value);
    // print(value);
    var berat = double.tryParse(value) ?? 0.0;
    switch (satuan.value) {
      case "ton":
        berat = berat * 1000000;
        break;
      case "kwintal":
        berat = berat * 100000;
        break;
      case "ons":
        berat = berat * 100;
        break;
      case "kg":
        berat = berat * 1000;
        break;
      case "gram":
        berat = berat * 1;
        break;
      default:
    }
    beratKonversi.value = berat;
    print(beratKonversi);
  }

  void notif(String msg) {
    Get.snackbar(
      "Gagal!",
      "$msg",
      backgroundColor: Colors.white,
    );
  }

  void cekOngkir() async {
    if (provIdAsal != 0) {
      if (idKotaAsal != 0) {
        if (provIdTujuan != 0) {
          if (idKotaTujuan != 0) {
            if (kurir != "") {
              print("berat $beratKonversi");
              try {
                Uri url = Uri.parse("https://api.rajaongkir.com/starter/cost");
                Map<String, dynamic> body = {
                  "origin": idKotaAsal.toString(),
                  "destination": idKotaTujuan.toString(),
                  "weight": beratKonversi.value.toString(),
                  "courier": kurir.toString(),
                };
                var response = await http.post(
                  url,
                  headers: {
                    "key": "1455b7037a7e7e8ed58dcb0656a99544",
                    "content-type": "application/x-www-form-urlencoded",
                  },
                  body: body,
                );
                var data = json.decode(response.body) as Map<String, dynamic>;
                var result = data['rajaongkir']['results'] as List<dynamic>;
                var cost = CostModel.fromJsonList(result)[0];
                Get.defaultDialog(
                  title: '${cost.name}',
                  content: Column(
                    children: cost.costs!
                        .map(
                          (e) => ListTile(
                            title: Text(
                              "${e.service}",
                            ),
                            subtitle: Text(
                              cost.code == 'pos'
                                  ? "${e.cost![0].etd}"
                                  : "${e.cost![0].etd} HARI",
                            ),
                            trailing: Text("Rp. ${e.cost![0].value}"),
                          ),
                        )
                        .toList(),
                  ),
                );
              } catch (e) {
                print(e);
              }
            } else {
              notif("Kurir belum diisi!");
            }
          } else {
            notif("Kota tujuan belum diisi!");
          }
        } else {
          notif("Provinsi tujuan belum diisi!");
        }
      } else {
        notif("Kota asal belum diisi!");
      }
    } else {
      notif("Provinsi asal belum diisi!");
    }
  }

  void konversi(String value) {
    satuan.value = value;
    print(satuan.value);
    var berat = double.tryParse(this.berat.text) ?? 0.0;
    switch (satuan.value) {
      case "ton":
        berat = berat * 1000000;
        break;
      case "kwintal":
        berat = berat * 100000;
        break;
      case "ons":
        berat = berat * 100;
        break;
      case "kg":
        berat = berat * 1000;
        break;
      case "gram":
        berat = berat * 1;
        break;
      default:
    }
    beratKonversi.value = berat;
  }
}
