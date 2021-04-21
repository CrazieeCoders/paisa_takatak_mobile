// To parse this JSON data, do
//
//     final uploadFileModel = uploadFileModelFromJson(jsonString);

import 'dart:convert';

UploadFileModel uploadFileModelFromJson(String str) => UploadFileModel.fromJson(json.decode(str));

String uploadFileModelToJson(UploadFileModel data) => json.encode(data.toJson());

class UploadFileModel {
  UploadFileModel({
    this.responseStatus,
    this.responseStatusCode,
    this.responseObject,
  });

  bool responseStatus;
  int responseStatusCode;
  List<ResponseObjectElement> responseObject;

  factory UploadFileModel.fromJson(Map<String, dynamic> json) => UploadFileModel(
    responseStatus: json["responseStatus"],
    responseStatusCode: json["responseStatusCode"],
    responseObject: List<ResponseObjectElement>.from(json["responseObject"].map((x) => ResponseObjectElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "responseStatus": responseStatus,
    "responseStatusCode": responseStatusCode,
    "responseObject": List<dynamic>.from(responseObject.map((x) => x.toJson())),
  };
}

class ResponseObjectElement {
  ResponseObjectElement({
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

  factory ResponseObjectElement.fromJson(Map<String, dynamic> json) => ResponseObjectElement(
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

  OcrResponseResponseObject responseObject;

  factory OcrResponse.fromJson(Map<String, dynamic> json) => OcrResponse(
    responseObject: OcrResponseResponseObject.fromJson(json["responseObject"]),
  );

  Map<String, dynamic> toJson() => {
    "responseObject": responseObject.toJson(),
  };
}

class OcrResponseResponseObject {
  OcrResponseResponseObject({
    this.action,
    this.type,
    this.status,
    this.requestId,
    this.taskId,
    this.groupId,
    this.createdAt,
    this.completedAt,
    this.result,
  });

  String action;
  String type;
  String status;
  String requestId;
  String taskId;
  String groupId;
  String createdAt;
  String completedAt;
  Result result;

  factory OcrResponseResponseObject.fromJson(Map<String, dynamic> json) => OcrResponseResponseObject(
    action: json["action"],
    type: json["type"],
    status: json["status"],
    requestId: json["request_id"],
    taskId: json["task_id"],
    groupId: json["group_id"],
    createdAt: json["created_at"],
    completedAt: json["completed_at"],
    result: Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "action": action,
    "type": type,
    "status": status,
    "request_id": requestId,
    "task_id": taskId,
    "group_id": groupId,
    "created_at": createdAt,
    "completed_at": completedAt,
    "result": result.toJson(),
  };
}

class Result {
  Result({
    this.extractionOutput,
    this.matchOutput,
  });

  ExtractionOutput extractionOutput;
  MatchOutput matchOutput;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    extractionOutput: ExtractionOutput.fromJson(json["extraction_output"]),
    matchOutput: MatchOutput.fromJson(json["match_output"]),
  );

  Map<String, dynamic> toJson() => {
    "extraction_output": extractionOutput.toJson(),
    "match_output": matchOutput.toJson(),
  };
}

class ExtractionOutput {
  ExtractionOutput({
    this.idNumber,
    this.nameOnCard,
    this.fathersName,
    this.dateOfBirth,
    this.yearOfBirth,
    this.gender,
    this.address,
    this.streetAddress,
    this.houseNumber,
    this.district,
    this.pincode,
    this.state,
    this.isScanned,
    this.dateOfIssue,
    this.age,
    this.panType,
    this.minor,
  });

  String idNumber;
  String nameOnCard;
  String fathersName;
  String dateOfBirth;
  String yearOfBirth;
  String gender;
  String address;
  String streetAddress;
  String houseNumber;
  String district;
  String pincode;
  String state;
  bool isScanned;
  String dateOfIssue;
  int age;
  dynamic panType;
  bool minor;

  factory ExtractionOutput.fromJson(Map<String, dynamic> json) => ExtractionOutput(
    idNumber: json["id_number"],
    nameOnCard: json["name_on_card"],
    fathersName: json["fathers_name"],
    dateOfBirth: json["date_of_birth"],
    yearOfBirth: json["year_of_birth"],
    gender: json["gender"],
    address: json["address"],
    streetAddress: json["street_address"],
    houseNumber: json["house_number"],
    district: json["district"],
    pincode: json["pincode"],
    state: json["state"],
    isScanned: json["is_scanned"],
    dateOfIssue: json["date_of_issue"],
    age: json["age"],
    panType: json["pan_type"],
    minor: json["minor"],
  );

  Map<String, dynamic> toJson() => {
    "id_number": idNumber,
    "name_on_card": nameOnCard,
    "fathers_name": fathersName,
    "date_of_birth": dateOfBirth,
    "year_of_birth": yearOfBirth,
    "gender": gender,
    "address": address,
    "street_address": streetAddress,
    "house_number": houseNumber,
    "district": district,
    "pincode": pincode,
    "state": state,
    "is_scanned": isScanned,
    "date_of_issue": dateOfIssue,
    "age": age,
    "pan_type": panType,
    "minor": minor,
  };
}

class MatchOutput {
  MatchOutput({
    this.nameOnCard,
    this.address,
    this.dobOnCard,
    this.number,
  });

  dynamic nameOnCard;
  dynamic address;
  dynamic dobOnCard;
  String number;

  factory MatchOutput.fromJson(Map<String, dynamic> json) => MatchOutput(
    nameOnCard: json["name_on_card"],
    address: json["address"],
    dobOnCard: json["dob_on_card"],
    number: json["number"],
  );

  Map<String, dynamic> toJson() => {
    "name_on_card": nameOnCard,
    "address": address,
    "dob_on_card": dobOnCard,
    "number": number,
  };
}
