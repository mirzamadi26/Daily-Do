import 'package:daily_do/utils/app_colors.dart';
import 'package:daily_do/utils/text_styles.dart';
import 'package:daily_do/view/home/controller/home_controller.dart';
import 'package:daily_do/view/home/controller/theme_controller.dart';
import 'package:daily_do/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader(
      {super.key, required this.controller, required this.themeController});

  final HomeController controller;
  final ThemeController themeController;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Get.width,
        decoration: BoxDecoration(
            color: kYellowColor,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15))),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    controller.fetchQuote();
                    Get.defaultDialog(
                        title: 'Random Quote',
                        content: Obx(() {
                          if (controller.isLoading.value) {
                            return CircularProgressIndicator();
                          } else {
                            return Text(
                              textAlign: TextAlign.justify,
                              controller.quote.value,
                              style: TextStyles.labelPoppinsTextStyle()
                                  .copyWith(
                                      fontSize: 14,
                                      color: kYellowColor,
                                      fontWeight: FontWeight.bold),
                            );
                          }
                        }),
                        confirm: SizedBox(
                          width: Get.width / 2,
                          child: CustomButtonWidget(
                            btnLabel: 'Close',
                            onTap: () {
                              Get.close(1);
                            },
                          ),
                        ));
                  },
                  child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: kWhiteColor),
                      child: Icon(
                        Icons.format_quote_sharp,
                        color: kGreenColor,
                        size: 30,
                      )),
                ),
                Obx(() => Text(
                      controller.loggedInUser.value?.username != null
                          ? "Hi, ${controller.loggedInUser.value?.username.split(' ').first}"
                          : "Hi,",
                      style: TextStyles.labelPoppinsTextStyle().copyWith(
                          fontSize: 28,
                          fontWeight: FontWeight.w500,
                          color: kBlackColor),
                    )),
                Obx(() => InkWell(
                      onTap: () {
                        themeController.toggleTheme();
                        controller.update();
                      },
                      child: Icon(
                        themeController.isDarkMode.value
                            ? Icons.dark_mode
                            : Icons.dark_mode_outlined,
                        size: 40,
                        color: Colors.brown,
                      ),
                    ))
              ],
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Today",
                style: TextStyles.labelPoppinsTextStyle().copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: kBlackColor),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: kGreenColor, borderRadius: BorderRadius.circular(12)),
              child: TableCalendar(
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: controller.focusedDay,
                selectedDayPredicate: (day) {
                  return isSameDay(controller.selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {},
                headerVisible: false,
                calendarFormat: CalendarFormat.week,
                availableCalendarFormats: const {
                  CalendarFormat.week: 'Week',
                },
                startingDayOfWeek: StartingDayOfWeek.monday,
                calendarStyle: CalendarStyle(
                  isTodayHighlighted: true,
                  todayTextStyle: TextStyles.labelPoppinsTextStyle().copyWith(
                      color: kWhiteColor, fontWeight: FontWeight.w500),
                  selectedTextStyle: TextStyles.labelPoppinsTextStyle()
                      .copyWith(
                          color: kWhiteColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                  selectedDecoration: BoxDecoration(
                    color: kYellowColor,
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: BoxDecoration(
                    color: Colors.redAccent,
                    shape: BoxShape.circle,
                  ),
                ),
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: TextStyle(color: Colors.black),
                  weekendStyle: TextStyle(color: Colors.red),
                ),
              ),
            ),
          ]),
        ));
  }
}
