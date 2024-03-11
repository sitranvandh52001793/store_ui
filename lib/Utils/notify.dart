import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

void showCustomToast({
  required BuildContext context,
  String title = 'Thông báo',
  String msg = 'Hello ',
  ToastificationType type = ToastificationType.success,
  IconData iconData = Icons.check,
  // Function()? onTap,
  // Function()? onCloseButtonTap,
  // Function()? onAutoCompleteCompleted,
  // Function()? onDismissed,
}) {
  toastification.show(
    context: context,
    type: type,
    autoCloseDuration: const Duration(seconds: 2),
    animationDuration: const Duration(milliseconds: 300),
    title: Text(title),
    description: RichText(
      text: TextSpan(
        text: msg,
      ),
    ),
    icon: Icon(iconData),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    borderRadius: BorderRadius.circular(12),
    showProgressBar: true,
    closeButtonShowType: CloseButtonShowType.onHover,
    closeOnClick: false,
    pauseOnHover: false,
    dragToClose: true,
  );
}
