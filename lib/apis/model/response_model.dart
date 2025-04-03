

class ResponseModel{
  final int status;
  final Map<String,dynamic>? body;
  final Map<String,dynamic>? errMsg;


  const ResponseModel({required this.status,this.body,this.errMsg});
}