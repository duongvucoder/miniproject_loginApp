import 'package:flutter/material.dart';

class ToastOverlay {
  final BuildContext context;
  OverlayEntry? overlayEntry;

  ToastOverlay(this.context);

  void showOverlay({required String messeage, ToastType = ToastType.error}) {
    if (overlayEntry != null) {
      overlayEntry!.remove();
      overlayEntry = null;
    }
    overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
        top: 64,
        left: 16,
        right: 16,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blue.shade200,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    messeage,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (overlayEntry != null) {
                      overlayEntry!.remove();
                      overlayEntry = null;
                    }
                  },
                  icon: const Icon(Icons.highlight_remove_sharp),
                )
              ],
            ),
          ),
        ),
      );
    });
    if (overlayEntry != null) {
      Overlay.of(context)!.insert(overlayEntry!);
      Future.delayed(const Duration(seconds: 2), () {
        if (overlayEntry != null) {
          overlayEntry!.remove();
          overlayEntry = null;
        }
      });
    }
  }
}

enum ToastType {
  succces,
  warning,
  infor,
  error,
}
