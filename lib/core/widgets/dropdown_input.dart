import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DropdownController<T> extends GetxController {
  var selectedValue = Rxn<T>(); // Reactive variable for selected value
  var items = <T>[].obs; // Reactive list of items

  void setSelectedValue(T value) {
    selectedValue.value = value;
  }

  void setItems(List<T> newItems) {
    items.value = newItems;
    // if (newItems.isNotEmpty) {
    //   selectedValue.value =
    //       newItems[0]; // Optionally select the first item by default
    // }
  }
}

class DropdownInput<T> extends StatelessWidget {
  final String? title;
  final String placeholder;
  final Color titleColor;
  final Color placeholderColor;
  final Color backgroundColor;
  final Color borderColor;
  final double borderRadius;
  final double borderWidth;
  final DropdownController<T> controller;
  final String Function(T) itemToString;
  final bool required;

  const DropdownInput({
    super.key,
    this.title,
    required this.placeholder,
    this.titleColor = const Color(0xFF1F1F1F),
    this.placeholderColor = const Color(0xFF7A7A7A),
    this.backgroundColor = const Color(0xFFF9FAFB),
    this.borderColor = const Color(0xFFD1D5DB),
    this.borderRadius = 8.0,
    this.borderWidth = 1.0,
    required this.controller,
    required this.itemToString, // Function to convert item to String
    this.required = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Row(
            children: [
              Text(
                title!,
                style: TextStyle(
                  color: titleColor,
                ),
              ),
              required
                  ? const Text(
                '*',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                ),
              )
                  : const SizedBox(),
            ],
          ),
        if (title != null) const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: borderColor,
              width: borderWidth,
            ),
          ),
          child: Obx(() {
            return DropdownButtonHideUnderline(
              child: DropdownButton<T>(
                value: controller.selectedValue.value,
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: placeholderColor,
                ),
                hint: Text(
                  placeholder,
                  style: TextStyle(
                    color: placeholderColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                isExpanded: true,
                items: controller.items.map<DropdownMenuItem<T>>((T value) {
                  return DropdownMenuItem<T>(
                    value: value,
                    child: Text(
                      itemToString(value),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: titleColor,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (newValue) {
                  if (newValue != null) {
                    controller.setSelectedValue(newValue);
                  }
                },
              ),
            );
          }),
        ),
      ],
    );
  }
}