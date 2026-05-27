class InvoiceListResponse {
  final InvoicePagination data;
  final bool success;
  final List<String> messages;

  InvoiceListResponse({
    required this.data,
    required this.success,
    required this.messages,
  });

  factory InvoiceListResponse.fromJson(Map<String, dynamic> json) {
    return InvoiceListResponse(
      data: InvoicePagination.fromJson(json['data']),
      success: json['success'] ?? false,
      messages: List<String>.from(json['messages'] ?? []),
    );
  }
}

class InvoicePagination {
  final int currentPage;
  final List<InvoiceModel> data;
  final int total;
  final int perPage;
  final int lastPage;

  InvoicePagination({
    required this.currentPage,
    required this.data,
    required this.total,
    required this.perPage,
    required this.lastPage,
  });

  factory InvoicePagination.fromJson(Map<String, dynamic> json) {
    return InvoicePagination(
      currentPage: json['current_page'] ?? 0,
      data: (json['data'] as List)
          .map((e) => InvoiceModel.fromJson(e))
          .toList(),
      total: json['total'] ?? 0,
      perPage: json['per_page'] ?? 0,
      lastPage: json['last_page'] ?? 0,
    );
  }
}

class InvoiceModel {
  final int id;
  final int customerId;
  final String invoiceNo;
  final String inDate;
  final String inTime;
  final double total;
  final double totalTax;
  final double grandTotal;
  final String? remarks;
  final int ifVat;
  final List<InvoiceDetail> detail;
  final List<InvoiceCustomer> customer;

  InvoiceModel({
    required this.id,
    required this.customerId,
    required this.invoiceNo,
    required this.inDate,
    required this.inTime,
    required this.total,
    required this.totalTax,
    required this.grandTotal,
    required this.remarks,
    required this.ifVat,
    required this.detail,
    required this.customer,
  });

  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    return InvoiceModel(
      id: json['id'] ?? 0,
      customerId: json['customer_id'] ?? 0,
      invoiceNo: json['invoice_no'] ?? '',
      inDate: json['in_date'] ?? '',
      inTime: json['in_time'] ?? '',
      total: (json['total'] ?? 0).toDouble(),
      totalTax: (json['total_tax'] ?? 0).toDouble(),
      grandTotal: (json['grand_total'] ?? 0).toDouble(),
      remarks: json['remarks'],
      ifVat: json['if_vat'] ?? 0,
      detail: (json['detail'] as List)
          .map((e) => InvoiceDetail.fromJson(e))
          .toList(),
      customer: (json['customer'] as List)
          .map((e) => InvoiceCustomer.fromJson(e))
          .toList(),
    );
  }
}

class InvoiceDetail {
  final int id;
  final int itemId;
  final String name;
  final String unit;
  final int quantity;
  final double mrp;
  final double amount;
  final String productType;

  InvoiceDetail({
    required this.id,
    required this.itemId,
    required this.name,
    required this.unit,
    required this.quantity,
    required this.mrp,
    required this.amount,
    required this.productType,
  });

  factory InvoiceDetail.fromJson(Map<String, dynamic> json) {
    return InvoiceDetail(
      id: json['id'] ?? 0,
      itemId: json['item_id'] ?? 0,
      name: json['name'] ?? '',
      unit: json['unit'] ?? '',
      quantity: json['quantity'] ?? 0,
      mrp: (json['mrp'] ?? 0).toDouble(),
      amount: (json['amount'] ?? 0).toDouble(),
      productType: json['product_type'] ?? '',
    );
  }
}

class InvoiceCustomer {
  final int id;
  final String name;
  final String contactNumber;

  InvoiceCustomer({
    required this.id,
    required this.name,
    required this.contactNumber,
  });

  factory InvoiceCustomer.fromJson(Map<String, dynamic> json) {
    return InvoiceCustomer(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      contactNumber: json['contact_number'] ?? '',
    );
  }
}