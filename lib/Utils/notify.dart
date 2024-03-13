import 'package:flutter/material.dart';
import 'package:store_ui/Styles/colors.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> successMessage({
  required BuildContext context,
  String? title = 'Thành công',
  required String message,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Container(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
        height: 50,
        decoration: BoxDecoration(
            color: success,
            borderRadius: const BorderRadius.all(Radius.circular(6))),
        child: Row(
          children: [
            const Icon(
              Icons.done,
              color: Colors.white,
              size: 30,
            ),
            const SizedBox(width: 20),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  message,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ))
          ],
        ),
      ),
      backgroundColor: success,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
    ),
  );
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> errorMessage({
  required BuildContext context,
  String? title = 'Thất bại',
  required String message,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Container(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
        height: 50,
        decoration: BoxDecoration(
            color: error,
            borderRadius: const BorderRadius.all(Radius.circular(6))),
        child: Row(
          children: [
            const Icon(
              Icons.error,
              color: Colors.white,
              size: 30,
            ),
            const SizedBox(width: 20),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  message,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ))
          ],
        ),
      ),
      backgroundColor: error,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
    ),
  );
}
