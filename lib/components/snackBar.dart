import 'package:flutter/material.dart';

class CustomSnackBar {
  String texto;
  CustomSnackBar(this.texto);

  SnackBar getSnackBar() {
    return SnackBar(
      content: Text(texto),
      backgroundColor: Colors.red,
      duration: const Duration(milliseconds: 3000),
      width: 280.0, // Width of the SnackBar.
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0, // Inner padding for SnackBar content.
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
