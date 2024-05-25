class CallLogData {
  CallLogData({
    required this.encId,
    required this.encKey,
    required this.deviceToken,
    required this.callData,
  });

  final String? encId;
  final String? encKey;
  final String? deviceToken;
  final List<CallDatum> callData;

  factory CallLogData.fromJson(Map<String, dynamic> json){
    return CallLogData(
      encId: json["enc_id"],
      encKey: json["enc_key"],
      deviceToken: json["device_token"],
      callData: json["call_data"] == null ? [] : List<CallDatum>.from(json["call_data"]!.map((x) => CallDatum.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "enc_id": encId,
    "enc_key": encKey,
    "device_token": deviceToken,
    "call_data": callData.map((x) => x.toJson()).toList(),
  };

}

class CallDatum {
  CallDatum({
    required this.callFrom,
    required this.fromCode,
    required this.callTo,
    required this.toCode,
    required this.type,
    required this.callTiming,
    required this.startTime,
    required this.endTime,
  });

  final String? callFrom;
  final String? fromCode;
  final String? callTo;
  final String? toCode;
  final String? type;
  final String? callTiming;
  final String? startTime;
  final String? endTime;

  factory CallDatum.fromJson(Map<String, dynamic> json){
    return CallDatum(
      callFrom: json["call_from"],
      fromCode: json["from_code"],
      callTo: json["call_to"],
      toCode: json["to_code"],
      type: json["type"],
      callTiming: json["call_timing"],
      startTime: json["start_time"],
      endTime: json["end_time"],
    );
  }

  Map<String, dynamic> toJson() => {
    "call_from": callFrom,
    "from_code": fromCode,
    "call_to": callTo,
    "to_code": toCode,
    "type": type,
    "call_timing": callTiming,
    "start_time": startTime,
    "end_time": endTime,
  };

}
