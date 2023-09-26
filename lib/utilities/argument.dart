class DeliveryDetailArguments {
  DeliveryDetailArguments({
    this.customerName,
    this.customerPhone,
    this.itemType,
    this.estimatedDateOfDelivery,
    this.itemDescription,
    this.itemQuantity,
    this.destination,
    this.noteId,
    this.status
  });

  String? customerName;
  String? customerPhone;
  String? itemType;
  String? estimatedDateOfDelivery;
  String? itemDescription;
  String? itemQuantity;
  String? destination;
  String? noteId;
  String? status;
}

class ConfirmDeliveryArguments {
  ConfirmDeliveryArguments(
      {this.customerName, this.customerPhone, this.noteId});

  String? customerName;
  String? customerPhone;
  String? noteId;
}
