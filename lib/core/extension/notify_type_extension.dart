import 'package:ct_social/core/enum/notify_type.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

extension NotifyTypeExtension on NotifyType {
  Widget get getIcon {
    switch (this) {
      case NotifyType.success:
        return Icon(Icons.check_circle, color: getContentColor, size: 10.w);
      case NotifyType.warning:
        return Icon(Icons.warning, color: getContentColor, size: 10.w);
      case NotifyType.error:
        return Icon(Icons.error, color: getContentColor, size: 10.w);
    }
  }

  Color get getBackgroundColor {
    switch (this) {
      case NotifyType.error:
        return Colors.red;
      case NotifyType.success:
        return Colors.green;
      case NotifyType.warning:
        return Colors.yellow;
    }
  }

  Color get getContentColor {
    switch (this) {
      case NotifyType.error:
        return Colors.white;
      case NotifyType.success:
        return Colors.black;
      case NotifyType.warning:
        return Colors.black;
    }
  }
}
