// To parse this JSON data, do
//
//     final uploadFileErrorModel = uploadFileErrorModelFromJson(jsonString);

import 'dart:convert';

UploadFileErrorModel uploadFileErrorModelFromJson(String str) => UploadFileErrorModel.fromJson(json.decode(str));

String uploadFileErrorModelToJson(UploadFileErrorModel data) => json.encode(data.toJson());

class UploadFileErrorModel {
  UploadFileErrorModel({
    this.responseStatus,
    this.responseStatusCode,
    this.responseObject,
  });

  bool responseStatus;
  int responseStatusCode;
  List<ResponseObject> responseObject;

  factory UploadFileErrorModel.fromJson(Map<String, dynamic> json) => UploadFileErrorModel(
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
    this.ocrResponse,
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
  OcrResponse ocrResponse;

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
    ocrResponse: OcrResponse.fromJson(json["ocrResponse"]),
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
    "ocrResponse": ocrResponse.toJson(),
  };
}

class OcrResponse {
  OcrResponse({
    this.responseObject,
  });

  dynamic responseObject;

  factory OcrResponse.fromJson(Map<String, dynamic> json) => OcrResponse(
    responseObject: json["responseObject"],
  );

  Map<String, dynamic> toJson() => {
    "responseObject": responseObject,
  };
}
