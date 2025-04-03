class ErrorModel {
  Errors? errors;

  ErrorModel({this.errors});

  ErrorModel.fromJson(Map<String, dynamic> json) {
    errors = json['errors'] != null ? Errors.fromJson(json['errors']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (errors != null) {
      data['errors'] = errors!.toJson();
    }
    return data;
  }
}

class Errors {
  ErrMsg? errMsg;

  Errors({this.errMsg});

  Errors.fromJson(Map<String, dynamic> json) {
    for (var key in json.keys) {
      if (json[key] != null) {
        errMsg = ErrMsg.fromJson(json[key]);
        break; // Stop at the first found error
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (errMsg != null) {
      data['common'] = errMsg!.toJson();
    }
    return data;
  }
}

class ErrMsg {
  final String? type;
  final String? value;
  final String msg;
  final String? path;
  final String? location;

  ErrMsg({this.type, this.value, required this.msg, this.path, this.location});

  factory ErrMsg.fromJson(Map<String, dynamic> json) {
    return ErrMsg(
      type: json['type'],
      value: json['value'],
      msg: json['msg'],
      path: json['path'],
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'value': value,
      'msg': msg,
      'path': path,
      'location': location,
    };
  }
}
