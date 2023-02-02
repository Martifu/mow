import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

Future<Color?> getDominantColor(String imageUrl) async {
  final PaletteGenerator palette = await PaletteGenerator.fromImageProvider(
    NetworkImage(imageUrl),
    maximumColorCount: 20,
  );

  return palette.dominantColor?.color;
}
