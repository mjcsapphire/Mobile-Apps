import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:triple_g/src/views/widgets/white_box.dart';

import '../../../core/helpers/helpers.dart';
import '../../../core/routes/routes.dart';
import '../../../core/utils/colors.dart';

class Sermons extends StatefulWidget {
  const Sermons({super.key});

  @override
  State<Sermons> createState() => _SermonsState();
}

class _SermonsState extends State<Sermons> {
  final focusDate = DateTime.now().obs;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            "SERMONS",
            textAlign: TextAlign.center,
            style: textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 2.h),
              Obx(() => WhiteBox(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    child: TableCalendar(
                      focusedDay: focusDate.value,
                      firstDay: DateTime.now(),
                      lastDay: DateTime.utc(3000),
                      rowHeight: 40,
                      daysOfWeekHeight: 40,
                      onDaySelected: (selectedDay, focusedDay) {
                        focusDate.value = selectedDay;
                      },
                      selectedDayPredicate: (day) {
                        return isSameDay(day, focusDate.value);
                      },
                      daysOfWeekStyle: DaysOfWeekStyle(
                        weekdayStyle: textTheme.bodySmall!.copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                        weekendStyle: textTheme.bodySmall!.copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      headerStyle: HeaderStyle(
                        titleCentered: true,
                        formatButtonVisible: false,
                        titleTextStyle: textTheme.bodySmall!.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      calendarStyle: CalendarStyle(
                        todayTextStyle: textTheme.bodySmall!.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                        ),
                        defaultTextStyle: textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                        weekendTextStyle: textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                        markerMargin: EdgeInsets.zero,
                        tablePadding: EdgeInsets.zero,
                        cellPadding: EdgeInsets.zero,
                        selectedTextStyle: textTheme.bodySmall!.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                        ),
                        todayDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          shape: BoxShape.rectangle,
                          color: AppColors.primaryColor,
                        ),
                        selectedDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          shape: BoxShape.rectangle,
                          color: AppColors.primaryColor,
                        ),
                        defaultDecoration: Helpers.calendarDecoration,
                        disabledDecoration: Helpers.calendarDecoration,
                        holidayDecoration: Helpers.calendarDecoration,
                        weekendDecoration: Helpers.calendarDecoration,
                        outsideDecoration: Helpers.calendarDecoration,
                        rowDecoration: Helpers.calendarDecoration,
                        rangeEndDecoration: Helpers.calendarDecoration,
                        rangeStartDecoration: Helpers.calendarDecoration,
                        markerDecoration: Helpers.calendarDecoration,
                        withinRangeDecoration: Helpers.calendarDecoration,
                      ),
                    ),
                  )),
              SizedBox(height: 2.h),
              GText(
                "Selected: December 27th",
                style: textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              GText(
                "Today: December 27th",
                style: textTheme.labelLarge!.copyWith(
                  color: AppColors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 2.h),
              ListView.builder(
                  itemCount: 3,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return WhiteBox(
                      onTap: () {
                        context.go(sermonsDetail, extra: {
                          "isLive": index == 0,
                        });
                      },
                      margin: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 6),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              GText(
                                index == 0
                                    ? "Title of the sermon and else"
                                    : "Title of and else",
                                style: textTheme.titleSmall!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              Column(
                                children: [
                                  if (index == 0)
                                    GText(
                                      "● Live",
                                      style: textTheme.bodySmall!.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.red,
                                      ),
                                    ),
                                  Row(
                                    children: [
                                      if (index != 2)
                                        const Icon(
                                          Icons.watch_later_outlined,
                                          color: AppColors.primaryColor,
                                          size: 16,
                                        ),
                                      SizedBox(width: 1.w),
                                      GText(
                                        index == 0
                                            ? "15:22"
                                            : index == 2
                                                ? "Starting in: 1h 4m 2s"
                                                : "3m",
                                        style: textTheme.labelLarge!.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: index == 2
                                              ? AppColors.grey
                                              : AppColors.primaryColor,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 1.h),
                          GText(
                            "The phrase \"literally anything\" is often used to express the idea that any possibility is on the table. It signifies a wide range of options or choices without any limitations.ˀ",
                            style: textTheme.bodySmall!.copyWith(
                              color: AppColors.darkGrey,
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
