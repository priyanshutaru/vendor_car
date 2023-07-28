// ignore_for_file: file_names, camel_case_types, unnecessary_new, prefer_collection_literals, unnecessary_this

class redeemTran {
  int? statusCode;
  String? statusMessage;
  List<Response>? response;

  redeemTran({this.statusCode, this.statusMessage, this.response});

  redeemTran.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    statusMessage = json['status_message'];
    if (json['response'] != null) {
      response = <Response>[];
      json['response'].forEach((v) {
        response!.add(new Response.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['status_message'] = this.statusMessage;
    if (this.response != null) {
      data['response'] = this.response!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Response {
  String? vendorId;
  String? paymentType;
  String? rent;
  String? comission;
  String? earn;
  String? transectionID;
  String? description;
  String? paymentStatus;
  String? createdAt;

  Response(
      {this.vendorId,
      this.paymentType,
      this.rent,
      this.comission,
      this.earn,
      this.transectionID,
      this.description,
      this.paymentStatus,
      this.createdAt});

  Response.fromJson(Map<String, dynamic> json) {
    vendorId = json['vendor_id'];
    paymentType = json['payment_type'];
    rent = json['rent'];
    comission = json['comission'];
    earn = json['earn'];
    transectionID = json['transection_ID'];
    description = json['description'];
    paymentStatus = json['payment_status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vendor_id'] = this.vendorId;
    data['payment_type'] = this.paymentType;
    data['rent'] = this.rent;
    data['comission'] = this.comission;
    data['earn'] = this.earn;
    data['transection_ID'] = this.transectionID;
    data['description'] = this.description;
    data['payment_status'] = this.paymentStatus;
    data['created_at'] = this.createdAt;
    return data;
  }
}
