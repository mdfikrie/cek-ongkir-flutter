import 'package:cek_ongkir/app/modules/home/views/components/berat.dart';
import 'package:cek_ongkir/app/modules/home/views/components/courir.dart';
import 'package:cek_ongkir/app/modules/home/views/components/kota_search.dart';
import 'package:cek_ongkir/app/modules/home/views/components/provinsi_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cek Ongkir'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            ProvinsiSearch(
              type: "asal",
            ),
            SizedBox(height: 10),
            Obx(
              () => controller.hiddenKotaAsal.isTrue
                  ? SizedBox()
                  : KotaSearch(
                      provId: controller.provIdAsal,
                      type: "asal",
                    ),
            ),
            SizedBox(height: 10),
            ProvinsiSearch(
              type: "tujuan",
            ),
            SizedBox(height: 10),
            Obx(
              () => controller.hiddenKotaTujuan.isTrue
                  ? SizedBox()
                  : KotaSearch(
                      provId: controller.provIdTujuan,
                      type: "tujuan",
                    ),
            ),
            SizedBox(height: 10),
            Berat(),
            SizedBox(height: 10),
            Courir(),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  padding: EdgeInsets.symmetric(vertical: 20)),
              onPressed: () {
                controller.cekOngkir();
              },
              child: Text("CEK ONGKIR", style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
