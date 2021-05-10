// To parse this JSON data, do
//
//     final homePageModel = homePageModelFromJson(jsonString);

import 'dart:convert';

HomePageModel homePageModelFromJson(String str) => HomePageModel.fromJson(json.decode(str));

String homePageModelToJson(HomePageModel data) => json.encode(data.toJson());

class HomePageModel {
  HomePageModel({
    this.code,
    this.message,
    this.data,
    this.localizedMessage,
  });

  int code;
  String message;
  Data data;
  String localizedMessage;

  factory HomePageModel.fromJson(Map<String, dynamic> json) => HomePageModel(
    code: json["code"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
    localizedMessage: json["localizedMessage"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": data.toJson(),
    "localizedMessage": localizedMessage,
  };
}

class Data {
  Data({
    this.customerName,
    this.accountNumber,
    this.apiLastUpdatedDate,
    this.aadharId,
    this.tollFreeNumber,
    this.customerCareEmail,
    this.loanDetails,
    this.transaction,
  });

  String customerName;
  dynamic accountNumber;
  dynamic apiLastUpdatedDate;
  String aadharId;
  String tollFreeNumber;
  String customerCareEmail;
  dynamic loanDetails;
  dynamic transaction;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    customerName: json["customerName"],
    accountNumber: json["accountNumber"],
    apiLastUpdatedDate: json["apiLastUpdatedDate"],
    aadharId: json["aadharId"],
    tollFreeNumber: json["tollFreeNumber"],
    customerCareEmail: json["customerCareEmail"],
    loanDetails: json["loanDetails"],
    transaction: json["transaction"],
  );

  Map<String, dynamic> toJson() => {
    "customerName": customerName,
    "accountNumber": accountNumber,
    "apiLastUpdatedDate": apiLastUpdatedDate,
    "aadharId": aadharId,
    "tollFreeNumber": tollFreeNumber,
    "customerCareEmail": customerCareEmail,
    "loanDetails": loanDetails,
    "transaction": transaction,
  };
}
