// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this

class bookingVenDetails {
  int? statusCode;
  String? statusMessage;
  String? path;
  List<Response>? response;

  bookingVenDetails(
      {this.statusCode, this.statusMessage, this.path, this.response});

  bookingVenDetails.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    statusMessage = json['status_message'];
    path = json['path'];
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
    data['path'] = this.path;
    if (this.response != null) {
      data['response'] = this.response!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Response {
  String? id;
  String? vendorId;
  String? vendorName;
  String? city;
  String? type;
  String? brand;
  String? category;
  String? transmissionType;
  String? commissionType;
  String? commissionAmt;
  String? vehicleName;
  String? modelNo;
  String? vehicleNo;
  String? seats;
  String? colour;
  String? minCharge;
  String? security;
  String? minKm;
  String? litre;
  Null? maxSpeed;
  String? ac;
  String? availableStatus;
  String? fuel;
  String? fuelType;
  String? vehicleImage;
  String? rcImage;
  String? vehicleStatus;
  String? driver;
  String? status;
  String? createdAt;
  String? updatedAt;

  Response(
      {this.id,
      this.vendorId,
      this.vendorName,
      this.city,
      this.type,
      this.brand,
      this.category,
      this.transmissionType,
      this.commissionType,
      this.commissionAmt,
      this.vehicleName,
      this.modelNo,
      this.vehicleNo,
      this.seats,
      this.colour,
      this.minCharge,
      this.security,
      this.minKm,
      this.litre,
      this.maxSpeed,
      this.ac,
      this.availableStatus,
      this.fuel,
      this.fuelType,
      this.vehicleImage,
      this.rcImage,
      this.vehicleStatus,
      this.driver,
      this.status,
      this.createdAt,
      this.updatedAt});

  Response.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    vendorName = json['vendor_name'];
    city = json['city'];
    type = json['type'];
    brand = json['brand'];
    category = json['category'];
    transmissionType = json['transmission_type'];
    commissionType = json['commission_type'];
    commissionAmt = json['commission_amt'];
    vehicleName = json['vehicle_name'];
    modelNo = json['model_no'];
    vehicleNo = json['vehicle_no'];
    seats = json['seats'];
    colour = json['colour'];
    minCharge = json['min_charge'];
    security = json['security'];
    minKm = json['min_km'];
    litre = json['litre'];
    maxSpeed = json['max_speed'];
    ac = json['ac'];
    availableStatus = json['available_status'];
    fuel = json['fuel'];
    fuelType = json['fuel_type'];
    vehicleImage = json['vehicle_image'];
    rcImage = json['rc_image'];
    vehicleStatus = json['vehicle_status'];
    driver = json['driver'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vendor_id'] = this.vendorId;
    data['vendor_name'] = this.vendorName;
    data['city'] = this.city;
    data['type'] = this.type;
    data['brand'] = this.brand;
    data['category'] = this.category;
    data['transmission_type'] = this.transmissionType;
    data['commission_type'] = this.commissionType;
    data['commission_amt'] = this.commissionAmt;
    data['vehicle_name'] = this.vehicleName;
    data['model_no'] = this.modelNo;
    data['vehicle_no'] = this.vehicleNo;
    data['seats'] = this.seats;
    data['colour'] = this.colour;
    data['min_charge'] = this.minCharge;
    data['security'] = this.security;
    data['min_km'] = this.minKm;
    data['litre'] = this.litre;
    data['max_speed'] = this.maxSpeed;
    data['ac'] = this.ac;
    data['available_status'] = this.availableStatus;
    data['fuel'] = this.fuel;
    data['fuel_type'] = this.fuelType;
    data['vehicle_image'] = this.vehicleImage;
    data['rc_image'] = this.rcImage;
    data['vehicle_status'] = this.vehicleStatus;
    data['driver'] = this.driver;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
