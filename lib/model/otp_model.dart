// To parse this JSON data, do
//
//     final otpModel = otpModelFromJson(jsonString);

import 'dart:convert';

OtpModel otpModelFromJson(String str) => OtpModel.fromJson(json.decode(str));

String otpModelToJson(OtpModel data) => json.encode(data.toJson());

class OtpModel {
  OtpModel({
    this.responseStatus,
    this.responseStatusCode,
    this.responseObject,
  });

  bool responseStatus;
  int responseStatusCode;
  ResponseObject responseObject;

  factory OtpModel.fromJson(Map<String, dynamic> json) => OtpModel(
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
    this.encyPass,
    this.documentStatus,
    this.token,
  });

  String encyPass;
  DocumentStatus documentStatus;
  String token;

  factory ResponseObject.fromJson(Map<String, dynamic> json) => ResponseObject(
    encyPass: json["encyPass"],
    documentStatus: DocumentStatus.fromJson(json["documentStatus"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "encyPass": encyPass,
    "documentStatus": documentStatus.toJson(),
    "token": token,
  };
}

class DocumentStatus {
  DocumentStatus({
    this.id,
    this.selfiePhoto,
    this.panCard,
    this.phoneNumber,
    this.aadharCard,
    this.cancelledCheque,
    this.loanApplicationForm,
    this.loanAgreementSigned,
    this.loanApplicationUnderProcess,
    this.createdDate,
    this.updateDate,
  });

  int id;
  int selfiePhoto;
  int panCard;
  String phoneNumber;
  int aadharCard;
  int cancelledCheque;
  int loanApplicationForm;
  int loanAgreementSigned;
  int loanApplicationUnderProcess;
  dynamic createdDate;
  dynamic updateDate;

  factory DocumentStatus.fromJson(Map<String, dynamic> json) => DocumentStatus(
    id: json["id"],
    selfiePhoto: json["selfiePhoto"],
    panCard: json["panCard"],
    phoneNumber: json["phoneNumber"],
    aadharCard: json["aadharCard"],
    cancelledCheque: json["cancelledCheque"],
    loanApplicationForm: json["loanApplicationForm"],
    loanAgreementSigned: json["loanAgreementSigned"],
    loanApplicationUnderProcess: json["loanApplicationUnderProcess"],
    createdDate: json["createdDate"],
    updateDate: json["updateDate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "selfiePhoto": selfiePhoto,
    "panCard": panCard,
    "phoneNumber": phoneNumber,
    "aadharCard": aadharCard,
    "cancelledCheque": cancelledCheque,
    "loanApplicationForm": loanApplicationForm,
    "loanAgreementSigned": loanAgreementSigned,
    "loanApplicationUnderProcess": loanApplicationUnderProcess,
    "createdDate": createdDate,
    "updateDate": updateDate,
  };
}
