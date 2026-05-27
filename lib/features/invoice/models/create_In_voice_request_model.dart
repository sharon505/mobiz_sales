class CreateInvoiceRequestModel {
  final int customerId;
  final int storeId;
  final int userId;
  final int vanId;
  final String saveMode;
  final int orderType;
  final double discount;
  final double total;
  final double totalTax;
  final double grandTotal;
  final double roundOff;
  final int ifVat;
  final String remarks;
  final List<int> itemIds;
  final List<int> quantities;
  final List<double> mrp;
  final List<int> productTypes;
  final List<int> units;

  CreateInvoiceRequestModel({
    required this.customerId,
    required this.storeId,
    required this.userId,
    required this.vanId,
    required this.saveMode,
    required this.orderType,
    required this.discount,
    required this.total,
    required this.totalTax,
    required this.grandTotal,
    required this.roundOff,
    required this.ifVat,
    required this.remarks,
    required this.itemIds,
    required this.quantities,
    required this.mrp,
    required this.productTypes,
    required this.units,
  });

  Map<String, dynamic> toJson() {
    return {
      "customer_id": customerId,
      "store_id": storeId,
      "user_id": userId,
      "van_id": vanId,
      "save_mode": saveMode,
      "order_type": orderType,
      "discount": discount,
      "total": total,
      "total_tax": totalTax,
      "grand_total": grandTotal,
      "round_off": roundOff,
      "if_vat": ifVat,
      "remarks": remarks,
      "item_id": itemIds,
      "quantity": quantities,
      "mrp": mrp,
      "product_type": productTypes,
      "unit": units,
    };
  }
}