import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:provider_app/res/app_colors.dart';
import 'package:provider_app/widgets/Fonts/app_fonts.dart';

class BidExpand extends StatelessWidget {
  const BidExpand({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return ExpandablePanel(
      theme: const ExpandableThemeData(
        useInkWell: false,
        hasIcon: false,
      ),
      header: Container(
        height: 60.0,
        width: width,
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          color: AppColors.blueColor,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:  [
            Expanded(
              child: Text(
                'Внимание',
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: Weights.bold
                ),
              ),
            ),
            Icon(Icons.keyboard_arrow_down, color: Colors.white),
          ],
        ),
      ),
      collapsed: const SizedBox(),
      expanded: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24.0),
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 24.0),
        width: width,
        decoration: const BoxDecoration(
          color: AppColors.blueColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(12.0),
            bottomRight: Radius.circular(12.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 24.0),
            text("•	Все обсуждения работы производите в чате."),
            text("•	Если договорились, то нажмите кнопку в чате «Договорились»."),
            text("•	После выполнения работ попросите клиента оставить отзыв о вас, это улучшит ваш профиль и рейтинг."),
            text("•	Выполнять работы надо качественно и в срок, избегать конфликтов с клиентами. При получении нескольких жалоб профиль может быть заблокирован."),

          ],
        ),
      ),
    );
  }

  Widget text(text1) =>  Padding(
    padding: EdgeInsets.only(bottom: 5.0),
    child: Text(text1,
      textAlign: TextAlign.justify,
      style: TextStyle(
        fontSize: 14.0,
        color: Colors.white,

        fontFamily: Weights.semi,
        fontWeight: FontWeight.w300,
      ),
    ),
  );

}
