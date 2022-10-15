import 'package:flutter/material.dart';
import 'package:gk/utils/constants/colors.constant.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final double? height;
  final double? width;
  final double? iconSize;
  final double? radius;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? hintColor;
  final bool? searchAble;
  final bool isPadding;
  final Icon? icon;
  const CustomTextField({
    Key? key,
    required,
    required this.hintText,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.radius,
    this.height,
    this.width,
    this.backgroundColor,
    this.hintColor,
    this.borderColor,
    this.searchAble,
    this.iconSize,
    this.icon,
    this.isPadding = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isPadding
          ? const EdgeInsets.symmetric(vertical: 8.0)
          : const EdgeInsets.symmetric(vertical: 0),
      child: SizedBox(
        height: height ?? 5.5.h,
        width: width ?? 25.w,
        child: TextField(
          controller: controller,
          // expands: true,
          style: TextStyle(color: hintColor ?? AppColors.whiteColor),
          decoration: InputDecoration(
            prefixIcon: icon ??
                Icon(
                  Icons.search,
                  size:  2.h,
                  color: hintColor,
                ),
            contentPadding: const EdgeInsets.only(left: 20,top: 10),
            filled: true,
            // fillColor: backgroundColor ?? AppColors.backgroundColor2,
            hintText: hintText,
            hintStyle: TextStyle(color: hintColor),
            // border: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(radius ?? 100),
            //   borderSide: BorderSide(
            //     color: backgroundColor ?? AppColors.whiteColor,
            //   ),
            // ),
            // focusedBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(radius ?? 100),
            //   borderSide: BorderSide(
            //     color: backgroundColor ?? AppColors.whiteColor,
            //   ),
            // ),
            // disabledBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(radius ?? 100),
            //   borderSide: BorderSide(
            //     color: backgroundColor ?? AppColors.backgroundColor2,
            //   ),
            // ),
            // errorBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(radius ?? 100),
            //   borderSide: BorderSide(
            //     color: backgroundColor ?? AppColors.backgroundColor2,
            //   ),
            // ),
          ),
          onChanged: onChanged,
          onSubmitted: onSubmitted,
        ),
      ),
    );
  }
}
