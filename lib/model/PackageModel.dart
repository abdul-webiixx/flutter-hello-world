// To parse this JSON data, do
//
//     final packageModel = packageModelFromJson(jsonString);

import 'dart:convert';

class PackageModel{
  PackageModel({
    this.id,
    this.name,
    this.package,
  });
  int? id;
  String? name;
  List<Package>? package;

  factory PackageModel.fromJson(Map<String, dynamic> json) => PackageModel(
    name: json["name"],
    package: List<Package>.from(json["package"].map((x) => Package.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id":id,
    "name": name,
    "package": List<dynamic>.from(package!.map((x) => x.toJson())),
  };
}

class Package {
  Package({
    this.id,
    this.name,
    this.url,
  });

  String? id;
  String? name;
  String? url;

  factory Package.fromJson(Map<String, dynamic> json) => Package(
    id: json["id"],
    name: json["name"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "url": url,
  };
}

