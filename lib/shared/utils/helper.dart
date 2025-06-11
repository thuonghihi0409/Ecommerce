import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:thuongmaidientu/core/app_color.dart';
import 'package:thuongmaidientu/core/app_text_style.dart';
import 'package:url_launcher/url_launcher.dart';

/// Toast type
enum ToastType { success, error }

/// Picker type
enum PickerType { takePhoto, gallery, video, recordVideo }

class Helper {
  /// Use when showing custom dialog
  static void showCustomDialog({
    required BuildContext context,
    String? message,
    Function()? onClose,
    bool isShowSecondButton = false,
    required Function() onPressPrimaryButton,
    onPressSecondButton,
    String? labelPrimary,
    labelSecondary,
    bool barrierDismissible = true,
    Widget? headerCustom,
    ValueNotifier<bool>? isDisablePrimaryButton,
    ScrollController? scrollController,
    bool isNeverScroll = false,
  }) {
    showDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (dialogContext) {
          return SingleChildScrollView(
            controller: scrollController,
            physics:
                isNeverScroll ? const NeverScrollableScrollPhysics() : null,
            child: ValueListenableBuilder(
                valueListenable: isDisablePrimaryButton ?? ValueNotifier(false),
                builder: (context, isDisableButton, child) {
                  return const Dialog(
                      // message: message,
                      // isShowSecondButton: isShowSecondButton,
                      // labelPrimary: labelPrimary,
                      // labelSecondary: labelSecondary,
                      // onPressSecondButton: onPressSecondButton,
                      // onClose: onClose,
                      // onPressPrimaryButton: onPressPrimaryButton,
                      // isShowCloseIcon: true,
                      // headerCustom: headerCustom,
                      // isDisablePrimaryButton: isDisableButton,
                      );
                }),
          );
        });
  }

  static Future<void> showAdditionalCustomDialog({
    required BuildContext context,
    required Widget customDialog,
    double? horizontalInsetPadding,
    double? verticalInsetPadding,
  }) async {
    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: AppColor.primary,
          insetPadding: EdgeInsets.symmetric(
            horizontal: horizontalInsetPadding ?? 150,
            vertical: verticalInsetPadding ?? 20,
          ),
          child: customDialog,
        );
      },
    );
  }

  /// Show toast message
  static void showToastBottom({
    required String message,
    ToastType type = ToastType.error,
    Duration? duration,
  }) {
    Color color = const Color(0xffFDEDEE);
    late Widget icon;
    switch (type) {
      case ToastType.success:
        color = const Color(0xffEBFBF6);
        icon = const Icon(
          Icons.check_circle,
          color: Colors.green,
        );
        break;
      case ToastType.error:
        icon = const Icon(
          Icons.error_outlined,
          color: Colors.red,
        );
        break;
    }

    showSimpleNotification(
        Row(
          children: [
            icon,
            const SizedBox(width: 8),
            Expanded(
                child: Linkify(
              text: message,
              style: AppTextStyles.textSize10(),
              linkStyle: AppTextStyles.textSize10()
                  .copyWith(decoration: TextDecoration.underline),
              onOpen: (link) => launchUrl(Uri.parse(link.url)),
              options: const LinkifyOptions(humanize: false),
            ))
          ],
        ),
        elevation: 0,
        background: color,
        duration: duration ?? const Duration(milliseconds: 3000),
        position: NotificationPosition.top,
        autoDismiss: true,
        slideDismissDirection: DismissDirection.up);
  }

  static String formatPhoneNumber(String phoneNumber) {
    if (phoneNumber.isEmpty) return phoneNumber;

    phoneNumber = phoneNumber.replaceAll(' ', '');

    String countryCode = '';
    if (phoneNumber.startsWith('+')) {
      int firstDigitIndex = phoneNumber.indexOf(RegExp(r'\d'));
      int secondDigitIndex = firstDigitIndex + 1;

      while (secondDigitIndex < phoneNumber.length &&
          secondDigitIndex - firstDigitIndex < 2 &&
          int.tryParse(phoneNumber.substring(
                  firstDigitIndex, secondDigitIndex + 1)) !=
              null) {
        secondDigitIndex++;
      }

      countryCode = phoneNumber.substring(0, secondDigitIndex);
      phoneNumber = phoneNumber.substring(secondDigitIndex);
    }

    List<String> parts = [];
    if (phoneNumber.length >= 3) {
      parts.add(phoneNumber.substring(0, 3));
    }
    if (phoneNumber.length >= 7) {
      parts.add(phoneNumber.substring(3, 7));
    }
    if (phoneNumber.length > 7) {
      parts.add(phoneNumber.substring(7));
    }

    return countryCode.isNotEmpty
        ? '$countryCode ${parts.join(' ')}'
        : parts.join(' ');
  }

  static String formatNumber(num number) {
    if (number >= 1000000000) {
      return '${(number / 1000000000).toStringAsFixed(1)}B';
    } else if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 10000) {
      return '${(number / 1000).toStringAsFixed(1)}k';
    } else if (number >= 1000) {
      final formatter = NumberFormat("#,###");
      return formatter.format(number);
    } else {
      return number.toString();
    }
  }

  static String extractDatePart(String input) {
    try {
      if (input.length == 10) {
        DateTime date = DateTime.parse(input);
        return "${date.day}";
      } else if (input.length == 7) {
        DateTime date = DateTime.parse("$input-01");
        return "${date.month}";
      } else if (input.length == 4) {
        return input;
      } else {
        return "";
      }
    } catch (e) {
      return "";
    }
  }
}
