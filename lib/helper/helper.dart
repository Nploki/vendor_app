import 'package:flutter/cupertino.dart';
import 'package:get/route_manager.dart';

class Helper {
  /// This is the common pop up dialog box contains both android and ios
  /// if you want only one button just pass primaryButtonName only
  /// don't pass anything functions to pop the popup box.
  static Future<void> commonPopUpDialog({
    String? title,
    required String message,
    required String primaryButtonName,
    VoidCallback? primaryButtonAction,
    String? secondaryButtonName,
    VoidCallback? secondaryButtonAction,
  }) async {
    await showCupertinoDialog<void>(
        context: Get.context!,
        builder: (BuildContext context) => CupertinoAlertDialog(
                title: title != null
                    ? Text(
                        title,
                        style: const TextStyle(),
                      )
                    : null,
                content: Text(
                  message,
                  style: const TextStyle(),
                ),
                actions: [
                  if (secondaryButtonName != null)
                    CupertinoDialogAction(
                      onPressed: () {
                        Get.back();
                        if (secondaryButtonAction != null) {
                          secondaryButtonAction();
                        }
                      },
                      textStyle: const TextStyle(),
                      child: Text(
                        secondaryButtonName[0] +
                            secondaryButtonName.substring(1).toLowerCase(),
                      ),
                    ),
                  CupertinoDialogAction(
                    onPressed: () {
                      Get.back();
                      if (primaryButtonAction != null) {
                        primaryButtonAction();
                      }
                    },
                    textStyle: const TextStyle(),
                    child: Text(
                      primaryButtonName[0] +
                          primaryButtonName.substring(1).toLowerCase(),
                    ),
                  ),
                ]));
  }
}
