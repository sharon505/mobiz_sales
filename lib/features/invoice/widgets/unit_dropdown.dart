import 'package:flutter/material.dart';

import '../../product/models/product_model.dart';

class UnitDropdown extends StatelessWidget {
  final ProductUnit? selectedUnit;
  final List<ProductUnit> units;
  final ValueChanged<ProductUnit?> onChanged;

  const UnitDropdown({
    super.key,
    required this.selectedUnit,
    required this.units,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<ProductUnit>(
      value: selectedUnit,
      decoration: const InputDecoration(
        labelText: "Select Unit",
        border: OutlineInputBorder(),
      ),
      items: units.map((unit) {
        return DropdownMenuItem(
          value: unit,
          child: Text("${unit.name} - ${unit.price}"),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}