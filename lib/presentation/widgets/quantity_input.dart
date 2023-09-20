import 'package:ecom_app/core/ui.dart';
import 'package:flutter/material.dart';

class QuantityInputWidget extends StatefulWidget {
  final int initialValue;
  final Function(int) onChanged;
  const QuantityInputWidget({
    Key? key,
    required this.initialValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<QuantityInputWidget> createState() => _QuantityInputWidgetState();
}

class _QuantityInputWidgetState extends State<QuantityInputWidget> {
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    _quantity = widget.initialValue;
  }

  void _incrementQuantity() {
    setState(() {
      _quantity++;
      widget.onChanged(_quantity);
    });
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
        widget.onChanged(_quantity);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: AppColors.accent)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: IconButton(
              color: AppColors.accent,
              icon: const Icon(Icons.remove),
              onPressed: _decrementQuantity,
            ),
          ),
          Text(
            '$_quantity',
            style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold, color: AppColors.textLight),
          ),
          Container(
            child: IconButton(
              color: AppColors.accent,
              icon: const Icon(Icons.add),
              onPressed: _incrementQuantity,
            ),
          ),
        ],
      ),
    );
  }
}
