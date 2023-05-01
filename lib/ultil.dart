import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kalkulator/theme.dart';

ElevatedButton Button(String angka,
    {Color? warna, Color? warna_bg, void Function()? onTap}) {
  return ElevatedButton(
    onPressed: onTap,
    style: ElevatedButton.styleFrom(
      shape: const CircleBorder(),
      backgroundColor: warna_bg ?? grey,
      padding: const EdgeInsets.all(10),
      minimumSize: const Size(56, 56),
      textStyle:
          GoogleFonts.roboto(fontSize: 30, fontWeight: FontWeight.normal),
      foregroundColor: warna ?? cyan, // mengatur ukuran minimal button
    ),
    child: SizedBox(
      width: 56,
      height: 56,
      child: Center(child: Text(angka)),
    ),
  );
}
