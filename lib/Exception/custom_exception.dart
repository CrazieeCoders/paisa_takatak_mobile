class AppException implements Exception{

  final msg;

  AppException({this.msg});
}


class ModelException extends AppException{
  String msg;
  ModelException({this.msg}):super(msg: msg);
}

class UnAuthorizedException extends AppException{
       String msg;
       UnAuthorizedException({this.msg}):super(msg: msg);
}

class ForbiddenException extends AppException{
      String msg;
      ForbiddenException({this.msg}):super(msg: msg);
}

class NotFoundException extends AppException{
  String msg;
  NotFoundException({this.msg}):super(msg: msg);
}


class FetchOtpException extends AppException{
  String msg;
  FetchOtpException({this.msg}):super(msg: msg);
}

class InvalidFileException extends AppException{
  String msg;
  InvalidFileException({this.msg});
}


