// To parse this JSON data, do
//
//     final costModel = costModelFromJson(jsonString);

import 'dart:convert';

CostModel costModelFromJson(String str) => CostModel.fromJson(json.decode(str));

String costModelToJson(CostModel data) => json.encode(data.toJson());

class CostModel {
  CostModel({
    this.code,
    this.name,
    this.costs,
  });

  String? code;
  String? name;
  List<CostModelCost>? costs;

  factory CostModel.fromJson(Map<String, dynamic> json) => CostModel(
        code: json["code"],
        name: json["name"],
        costs: List<CostModelCost>.from(
            json["costs"].map((x) => CostModelCost.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "costs": List<dynamic>.from(costs!.map((x) => x.toJson())),
      };

  static List<CostModel> fromJsonList(List list) {
    if (list.length == 0) return List<CostModel>.empty();
    return list.map((item) => CostModel.fromJson(item)).toList();
  }
}

class CostModelCost {
  CostModelCost({
    this.service,
    this.description,
    this.cost,
  });

  String? service;
  String? description;
  List<CostCost>? cost;

  factory CostModelCost.fromJson(Map<String, dynamic> json) => CostModelCost(
        service: json["service"],
        description: json["description"],
        cost:
            List<CostCost>.from(json["cost"].map((x) => CostCost.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "service": service,
        "description": description,
        "cost": List<dynamic>.from(cost!.map((x) => x.toJson())),
      };
}

class CostCost {
  CostCost({
    this.value,
    this.etd,
    this.note,
  });

  int? value;
  String? etd;
  String? note;

  factory CostCost.fromJson(Map<String, dynamic> json) => CostCost(
        value: json["value"],
        etd: json["etd"],
        note: json["note"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "etd": etd,
        "note": note,
      };
}
