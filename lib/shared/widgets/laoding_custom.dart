import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:thuongmaidientu/core/app_color.dart';

/// Show loader when waiting for something
class CustomLoading extends StatelessWidget {
  final bool isOverlay;
  final bool isLoading;
  final double strokeWidth;
  const CustomLoading(
      {super.key,
      this.isOverlay = false,
      this.isLoading = false,
      this.strokeWidth = 4});

  @override
  Widget build(BuildContext context) {
    if (isOverlay) {
      if (isLoading) {
        return SizedBox(
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.2),
                ),
              ),
              Positioned.fill(
                  child: Center(
                child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: const Color(0xff262626),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.center,
                    child: const _Loading()),
              )),
            ],
          ),
        );
      }
      return const SizedBox();
    }
    if (isLoading) {
      return Center(
          child: _Loading(
        strokeWidth: strokeWidth,
      ));
    }
    return const SizedBox();
  }
}

class _Loading extends StatelessWidget {
  final double strokeWidth;
  const _Loading({this.strokeWidth = 2});

  @override
  Widget build(BuildContext context) {
    return const SpinKitSpinningLines(
      color: AppColor.primary,
      duration: Duration(milliseconds: 2500),
      itemCount: 20,
    );
  }
}
