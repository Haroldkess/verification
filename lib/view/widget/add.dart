import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  VoidCallback onTap;
  AddButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(8)),
        child: const Center(
          child: Icon(
            Icons.add,
            size: 20,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
