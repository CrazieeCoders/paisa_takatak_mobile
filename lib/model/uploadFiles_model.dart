// To parse this JSON data, do
//
//     final validateModel = validateModelFromJson(jsonString);

import 'dart:convert';

ValidateModel validateModelFromJson(String str) => ValidateModel.fromJson(json.decode(str));

String validateModelToJson(ValidateModel data) => json.encode(data.toJson());

class ValidateModel {
  ValidateModel({
    this.responseStatus,
    this.responseStatusCode,
    this.responseObject,
  });

  bool responseStatus;
  int responseStatusCode;
  List<ResponseObject> responseObject;

  factory ValidateModel.fromJson(Map<String, dynamic> json) => ValidateModel(
    responseStatus: json["responseStatus"],
    responseStatusCode: json["responseStatusCode"],
    responseObject: List<ResponseObject>.from(json["responseObject"].map((x) => ResponseObject.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "responseStatus": responseStatus,
    "responseStatusCode": responseStatusCode,
    "responseObject": List<dynamic>.from(responseObject.map((x) => x.toJson())),
  };
}

class ResponseObject {
  ResponseObject({
    this.number,
    this.fileName,
    this.url,
    this.fileType,
    this.createdBy,
    this.updateBy,
    this.createdDate,
    this.updatedDate,
    this.fileSize,
    this.id,
  });

  String number;
  String fileName;
  String url;
  String fileType;
  String createdBy;
  dynamic updateBy;
  DateTime createdDate;
  dynamic updatedDate;
  int fileSize;
  dynamic id;

  factory ResponseObject.fromJson(Map<String, dynamic> json) => ResponseObject(
    number: json["number"],
    fileName: json["fileName"],
    url: json["url"],
    fileType: json["fileType"],
    createdBy: json["createdBy"],
    updateBy: json["updateBy"],
    createdDate: DateTime.parse(json["createdDate"]),
    updatedDate: json["updatedDate"],
    fileSize: json["fileSize"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "number": number,
    "fileName": fileName,
    "url": url,
    "fileType": fileType,
    "createdBy": createdBy,
    "updateBy": updateBy,
    "createdDate": createdDate.toIso8601String(),
    "updatedDate": updatedDate,
    "fileSize": fileSize,
    "id": id,
  };
}
