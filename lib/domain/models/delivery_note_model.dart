class DeliveryNote {
  String? success;
  List<DeliveryData>? data;

  DeliveryNote({this.success, this.data});

  DeliveryNote.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != String) {
      data = <DeliveryData>[];
      json['data'].forEach((v) {
        data!.add(DeliveryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (data != String) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DeliveryData {
  String? id;
  String? clintId;
  String? staffId;
  String? customerName;
  String? receiversName;
  String? address;
  String? itemType;
  String? estimatedDateOfDelivery;
  String? itemDescription;
  String? itemQuantity;
  String? customerPhone;
  String? receiversPhone;
  String? otp;
  String? signature;
  String? phote;
  String? attachment;
  String? status;
  String? createdAt;
  String? updatedAt;

  DeliveryData({
    this.id,
    this.clintId,
    this.staffId,
    this.customerName,
    this.receiversName,
    this.address,
    this.itemType,
    this.estimatedDateOfDelivery,
    this.itemDescription,
    this.itemQuantity,
    this.customerPhone,
    this.receiversPhone,
    this.otp,
    this.signature,
    this.phote,
    this.attachment,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  DeliveryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clintId = json['clint_id'];
    staffId = json['staff_id'];
    customerName = json['customer_name'];
    receiversName = json['receivers_name'];
    address = json['address'];
    itemType = json['item_type'];
    estimatedDateOfDelivery = json['estimated_date_of_delivery'];
    itemDescription = json['item_description'];
    itemQuantity = json['item_quantity'];
    customerPhone = json['customer_phone'];
    receiversPhone = json['receivers_phone'];
    otp = json['otp'];
    signature = json['signature'];
    phote = json['phote'];
    attachment = json['attachment'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['clint_id'] = clintId;
    data['staff_id'] = staffId;
    data['customer_name'] = customerName;
    data['receivers_name'] = receiversName;
    data['address'] = address;
    data['item_type'] = itemType;
    data['estimated_date_of_delivery'] = estimatedDateOfDelivery;
    data['item_description'] = itemDescription;
    data['item_quantity'] = itemQuantity;
    data['customer_phone'] = customerPhone;
    data['receivers_phone'] = receiversPhone;
    data['otp'] = otp;
    data['signature'] = signature;
    data['phote'] = phote;
    data['attachment'] = attachment;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  toLowerCase() {}
}
