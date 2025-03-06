import 'package:audition/core/data/app_toast.dart';
import 'package:audition/resources/app_constants/app_string.dart';
import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final Function(String) searchReels;
  final Function() clearData;
  final TextEditingController controller;
  const SearchField(
      {super.key,
      required this.searchReels,
      required this.controller,
      required this.clearData});
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white, fontSize: 18),
      decoration: InputDecoration(
          suffixIcon: IconButton(
              onPressed: () {
                if (controller.text.isEmpty) {
                  appToast(msg: "Please enter a text");
                  clearData();
                  return;
                }
                searchReels(controller.text);
              },
              icon: const Icon(
                Icons.done,
                color: Colors.white,
              )),
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
          hintText: AppString.search,
          hintStyle: const TextStyle(color: Colors.white, fontSize: 18),
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.white,
            size: 28,
          )),
    );
  }
}
