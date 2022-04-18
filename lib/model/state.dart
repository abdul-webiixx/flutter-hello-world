import 'dart:convert';
import 'package:Zenith/utils/enum.dart';

StateModel stateListModelFromJson(String str) =>
    StateModel.fromJson(json.decode(str));

String stateListModelToJson(StateModel data) => json.encode(data.toJson());

class StateModel {
  StateModel({
    this.status,
    this.success = false,
    this.message,
    this.states,
    this.requestStatus = RequestStatus.loading,
  });

  final int? status;
  final dynamic success;
  final String? message;
  List<StateListItem>? states;
  late RequestStatus requestStatus;

  factory StateModel.fromJson(Map<String, dynamic> json) => StateModel(
        status: json["status"],
        message: json["message"],
        states: json["data"]!=null ? List<StateListItem>.from(
            json["data"].map((x) => StateListItem.fromJson(x))) : null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": states!=null ? List<dynamic>.from(states!.map((x) => x.toJson())) : null,
      };
}

class StateListItem {
  StateListItem({
    this.id,
    this.name,
    this.countryId,
  });

  int? id;
  String? name;
  int? countryId;

  factory StateListItem.fromJson(Map<String, dynamic> json) => StateListItem(
        id: json["id"],
        name: json["name"],
        countryId: json["country_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "country_id": countryId,
      };
}
