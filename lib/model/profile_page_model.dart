// To parse this JSON data, do
//
//     final profilePageModel = profilePageModelFromJson(jsonString);

import 'dart:convert';

ProfilePageModel profilePageModelFromJson(String str) => ProfilePageModel.fromJson(json.decode(str));

String profilePageModelToJson(ProfilePageModel data) => json.encode(data.toJson());

class ProfilePageModel {
  ProfilePageModel({
    this.responseStatus,
    this.responseStatusCode,
    this.responseObject,
  });

  bool responseStatus;
  int responseStatusCode;
  ResponseObject responseObject;

  factory ProfilePageModel.fromJson(Map<String, dynamic> json) => ProfilePageModel(
    responseStatus: json["responseStatus"],
    responseStatusCode: json["responseStatusCode"],
    responseObject: ResponseObject.fromJson(json["responseObject"]),
  );

  Map<String, dynamic> toJson() => {
    "responseStatus": responseStatus,
    "responseStatusCode": responseStatusCode,
    "responseObject": responseObject.toJson(),
  };
}

class ResponseObject {
  ResponseObject({
    this.name,
    this.primaryContactNumber,
    this.secondaryContactNumber,
    this.permanentAddress,
    this.localAddress,
    this.areaPinCode,
    this.localPinCode,
    this.panNumber,
    this.aadharId,
  });

  dynamic name;
  String primaryContactNumber;
  String secondaryContactNumber;
  String permanentAddress;
  String localAddress;
  String areaPinCode;
  dynamic localPinCode;
  String panNumber;
  String aadharId;

  factory ResponseObject.fromJson(Map<String, dynamic> json) => ResponseObject(
    name: json["name"],
    primaryContactNumber: json["primaryContactNumber"],
    secondaryContactNumber: json["secondaryContactNumber"],
    permanentAddress: json["permanentAddress"],
    localAddress: json["localAddress"],
    areaPinCode: json["areaPinCode"],
    localPinCode: json["localPinCode"],
    panNumber: json["panNumber"],
    aadharId: json["aadharId"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "primaryContactNumber": primaryContactNumber,
    "secondaryContactNumber": secondaryContactNumber,
    "permanentAddress": permanentAddress,
    "localAddress": localAddress,
    "areaPinCode": areaPinCode,
    "localPinCode": localPinCode,
    "panNumber": panNumber,
    "aadharId": aadharId,
  };
}
