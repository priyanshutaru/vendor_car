// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this, unnecessary_question_mark, prefer_void_to_null

class bookingVen {
  int? statusCode;
  String? statusMessage;
  String? path;
  List<Response>? response;

  bookingVen({this.statusCode, this.statusMessage, this.path, this.response});

  bookingVen.fromJson(Map<String, dynamic> json) {
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
  String? invoiceId;
  String? userId;
  String? username;
  String? contact;
  String? pickupDate;
  String? pickupTime;
  String? dropDate;
  String? dropTime;
  String? creatDate;
  String? pickupAddress;
  String? dropAddress;
  String? vehicleType;
  String? paymentStatus;
  String? paymentMode;
  Null? startingMeter;
  String? startingKm;
  String? vehicleId;
  String? couponId;
  String? coupon;
  String? slot;
  String? totalKm;
  String? totalHrs;
  Null? damageVendor;
  Null? damageAmount;
  Null? damageShowVendor;
  String? damageReason;
  Null? damage;
  Null? timePenalty;
  Null? kmPenalty;
  Null? hourPenalty;
  String? penality;
  Null? finishTime;
  String? endReading;
  Null? endMeter;
  String? rent;
  String? tax;
  String? deliveryCharge;
  String? discount;
  String? advance;
  String? totalRent;
  String? totalPaidRent;
  String? rideStatus;
  String? seenStatus;
  String? transectionIds;
  String? bookedBy;

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
      this.updatedAt,
      this.invoiceId,
      this.userId,
      this.username,
      this.contact,
      this.pickupDate,
      this.pickupTime,
      this.dropDate,
      this.dropTime,
      this.creatDate,
      this.pickupAddress,
      this.dropAddress,
      this.vehicleType,
      this.paymentStatus,
      this.paymentMode,
      this.startingMeter,
      this.startingKm,
      this.vehicleId,
      this.couponId,
      this.coupon,
      this.slot,
      this.totalKm,
      this.totalHrs,
      this.damageVendor,
      this.damageAmount,
      this.damageShowVendor,
      this.damageReason,
      this.damage,
      this.timePenalty,
      this.kmPenalty,
      this.hourPenalty,
      this.penality,
      this.finishTime,
      this.endReading,
      this.endMeter,
      this.rent,
      this.tax,
      this.deliveryCharge,
      this.discount,
      this.advance,
      this.totalRent,
      this.totalPaidRent,
      this.rideStatus,
      this.seenStatus,
      this.transectionIds,
      this.bookedBy});

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
    invoiceId = json['invoice_id'];
    userId = json['user_id'];
    username = json['username'];
    contact = json['contact'];
    pickupDate = json['pickup_date'];
    pickupTime = json['pickup_time'];
    dropDate = json['drop_date'];
    dropTime = json['drop_time'];
    creatDate = json['creat_date'];
    pickupAddress = json['pickup_address'];
    dropAddress = json['drop_address'];
    vehicleType = json['vehicle_type'];
    paymentStatus = json['payment_status'];
    paymentMode = json['payment_mode'];
    startingMeter = json['starting_meter'];
    startingKm = json['starting_km'];
    vehicleId = json['vehicle_id'];
    couponId = json['coupon_id'];
    coupon = json['coupon'];
    slot = json['slot'];
    totalKm = json['total_km'];
    totalHrs = json['total_hrs'];
    damageVendor = json['damage_vendor'];
    damageAmount = json['damage_amount'];
    damageShowVendor = json['damage_show_vendor'];
    damageReason = json['damage_reason'];
    damage = json['damage'];
    timePenalty = json['time_penalty'];
    kmPenalty = json['km_penalty'];
    hourPenalty = json['hour_penalty'];
    penality = json['penality'];
    finishTime = json['finish_time'];
    endReading = json['end_reading'];
    endMeter = json['end_meter'];
    rent = json['rent'];
    tax = json['tax'];
    deliveryCharge = json['delivery_charge'];
    discount = json['discount'];
    advance = json['advance'];
    totalRent = json['total_rent'];
    totalPaidRent = json['total_paid_rent'];
    rideStatus = json['ride_status'];
    seenStatus = json['seen_status'];
    transectionIds = json['transection_ids'];
    bookedBy = json['booked_by'];
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
    data['invoice_id'] = this.invoiceId;
    data['user_id'] = this.userId;
    data['username'] = this.username;
    data['contact'] = this.contact;
    data['pickup_date'] = this.pickupDate;
    data['pickup_time'] = this.pickupTime;
    data['drop_date'] = this.dropDate;
    data['drop_time'] = this.dropTime;
    data['creat_date'] = this.creatDate;
    data['pickup_address'] = this.pickupAddress;
    data['drop_address'] = this.dropAddress;
    data['vehicle_type'] = this.vehicleType;
    data['payment_status'] = this.paymentStatus;
    data['payment_mode'] = this.paymentMode;
    data['starting_meter'] = this.startingMeter;
    data['starting_km'] = this.startingKm;
    data['vehicle_id'] = this.vehicleId;
    data['coupon_id'] = this.couponId;
    data['coupon'] = this.coupon;
    data['slot'] = this.slot;
    data['total_km'] = this.totalKm;
    data['total_hrs'] = this.totalHrs;
    data['damage_vendor'] = this.damageVendor;
    data['damage_amount'] = this.damageAmount;
    data['damage_show_vendor'] = this.damageShowVendor;
    data['damage_reason'] = this.damageReason;
    data['damage'] = this.damage;
    data['time_penalty'] = this.timePenalty;
    data['km_penalty'] = this.kmPenalty;
    data['hour_penalty'] = this.hourPenalty;
    data['penality'] = this.penality;
    data['finish_time'] = this.finishTime;
    data['end_reading'] = this.endReading;
    data['end_meter'] = this.endMeter;
    data['rent'] = this.rent;
    data['tax'] = this.tax;
    data['delivery_charge'] = this.deliveryCharge;
    data['discount'] = this.discount;
    data['advance'] = this.advance;
    data['total_rent'] = this.totalRent;
    data['total_paid_rent'] = this.totalPaidRent;
    data['ride_status'] = this.rideStatus;
    data['seen_status'] = this.seenStatus;
    data['transection_ids'] = this.transectionIds;
    data['booked_by'] = this.bookedBy;
    return data;
  }
}
