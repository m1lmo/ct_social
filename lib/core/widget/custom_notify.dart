import 'package:ct_social/core/enum/notify_type.dart';
import 'package:ct_social/core/extension/notify_type_extension.dart';
import 'package:ct_social/core/extension/theme_getter_extension.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomNotify {
  CustomNotify(this.overlayState, {required this.tickerProviderService, this.duration, this.title, this.type = NotifyType.error, this.message = ''}) {
    _animationController = AnimationController(
      vsync: tickerProviderService,
      duration: const Duration(milliseconds: 400),
    );
  }
  final String? title;
  final int? duration;
  final NotifyType type;
  final OverlayState overlayState;
  String? message;
  bool isOpen = false;
  final TickerProvider tickerProviderService;
  late OverlayEntry overlayEntry;
  late AnimationController _animationController;
  Future<void> show() async {
    await _animationController.forward();
    isOpen = true;
    overlayEntry = OverlayEntry(
      builder: (context) {
        return SlideTransition(
          position: Tween<Offset>(begin: const Offset(0, -1), end: const Offset(0, 0)).animate(_animationController),
          child: Align(
            alignment: Alignment.topCenter,
            child: Wrap(
              children: [
                Card(
                  surfaceTintColor: Colors.transparent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.w)),
                  color: type.getBackgroundColor,
                  elevation: 12,
                  margin: EdgeInsets.all(20.w).copyWith(top: 15.w),
                  child: Padding(
                    padding: EdgeInsets.all(2.w),
                    child: Row(
                      children: [
                        type.getIcon,
                        SizedBox(width: 2.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title ?? '',
                              style: context.theme.textTheme.headlineLarge?.copyWith(color: type.getContentColor, fontSize: 12.sp),
                            ),
                            SizedBox(height: 1.w),
                            Center(
                              child: Text(
                                message ?? '',
                                style: context.theme.textTheme.headlineMedium?.copyWith(color: type.getContentColor, fontSize: 10.sp),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    overlayState.insert(overlayEntry);
    Future.delayed(Duration(milliseconds: duration ?? 3000), () {
      _animationController.reverse().then((_) {
        if (overlayEntry.mounted) {
          overlayEntry.remove();
        }
      });
      isOpen = false;
    });
  }
}
