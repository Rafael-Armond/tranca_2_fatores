import 'package:flutter/material.dart';

class CustomLoadingProgressIndicator {
  static OverlayEntry? _overlayEntry;

  static Future<void> show(BuildContext context) async {
    _overlayEntry = _createOverlayEntry(context);
    Overlay.of(context)?.insert(_overlayEntry!);
  }

  static void hide() {
    _overlayEntry?.remove();
  }

  static OverlayEntry _createOverlayEntry(BuildContext context) {
    return OverlayEntry(
      builder: (context) => Container(
        color: Colors.black.withOpacity(0.5),
        height: double.infinity,
        width: double.infinity,
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
