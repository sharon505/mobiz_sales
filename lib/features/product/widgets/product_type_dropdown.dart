import 'package:flutter/material.dart';

import '../models/product_type_model.dart';

class ProductTypeDropdown extends StatelessWidget {
  final ProductTypeModel? selectedValue;
  final List<ProductTypeModel> productTypes;
  final ValueChanged<ProductTypeModel?> onChanged;

  const ProductTypeDropdown({
    super.key,
    required this.selectedValue,
    required this.productTypes,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<ProductTypeModel>(
      value: selectedValue,
      decoration: const InputDecoration(
        labelText: "Product Type",
        border: OutlineInputBorder(),
      ),
      items: productTypes.map((type) {
        return DropdownMenuItem(
          value: type,
          child: Text(type.name),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}