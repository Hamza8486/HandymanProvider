import 'package:flutter/material.dart';
import 'package:provider_app/res/app_colors.dart';


class AccountButtons extends StatelessWidget {
  final VoidCallback? onTap;
  final IconData? icon;
  final String? title;

  const AccountButtons({Key? key,
    required this.onTap,
    this.icon = Icons.location_on,
    this.title = 'Title',
}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 16.0),
            Icon(icon,
                color: AppColors.greyColor),
            const SizedBox(width: 16.0),
            Text(title!,
              style: const TextStyle(
                fontSize: 16.0,
                fontFamily: "Poppins",

                color: AppColors.blackColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
