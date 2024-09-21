import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rise_pathway/core/constants/package_export.dart';
import 'package:rise_pathway/core/helpers/helpers.dart';
import 'package:rise_pathway/core/utils/colors.dart';
import 'package:rise_pathway/src/views/widget/app_bar.dart';
import 'package:rise_pathway/src/views/widget/rise_button.dart';
import 'package:table_calendar/table_calendar.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final focusDate = DateTime.now().obs;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: RiseAppBar.riseAppBar(
        theme: Theme.of(context).textTheme,
        title: 'Calender',
        onTap: () => context.pop(),
        backgroundColor: AppColors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Column(
          children: [
            Obx(() {
              log(focusDate.value.toString());
              return TableCalendar(
                focusedDay: focusDate.value,
                firstDay: DateTime.now(),
                lastDay: DateTime.utc(3000),
                rowHeight: 45,
                daysOfWeekHeight: 45,
                onDaySelected: (selectedDay, focusedDay) {
                
                  focusDate.value = selectedDay;
        
                },
                selectedDayPredicate: (day) {
                  return isSameDay(day, focusDate.value);
                },
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: theme.bodySmall!.copyWith(
                    color: AppColors.daysOfWeekColor,
                  ),
                  weekendStyle: theme.bodySmall!.copyWith(
                    color: AppColors.daysOfWeekColor,
                  ),
                ),
                headerStyle: HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false,
                  titleTextStyle: theme.bodySmall!.copyWith(
                    color: AppColors.blue600,
                  ),
                ),
                calendarStyle: CalendarStyle(
                  todayTextStyle: theme.bodyMedium!.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  defaultTextStyle: theme.bodyMedium!.copyWith(
                    color: AppColors.black,
                  ),
                  weekendTextStyle: theme.bodyMedium!.copyWith(
                    color: AppColors.black,
                  ),
                  markerMargin: EdgeInsets.zero,
                  tablePadding: EdgeInsets.zero,
                  cellPadding: EdgeInsets.zero,
                  selectedTextStyle: theme.bodyMedium!.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  todayDecoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    shape: BoxShape.rectangle,
                    color: AppColors.blue400,
                  ),
                  selectedDecoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    shape: BoxShape.rectangle,
                    color: AppColors.blue600,
                  ),
                ),
              );
            }),
            SizedBox(height: 2.h),
            Align(
              alignment: Alignment.centerLeft,
              child: RiseText(
                'Available Times',
                style: theme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 2.h),
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 16,
                mainAxisExtent: 48,
              ),
              itemBuilder: (context, index) => Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.black.withOpacity(0.03),
                  ),
                  borderRadius: BorderRadius.circular(10),
                  color: index == 5 ? AppColors.blue600 : AppColors.white,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withOpacity(0.02),
                      blurRadius: 12,
                    )
                  ],
                ),
                child: RiseText(
                  '${1 + index}:${15 + index} AM',
                  style: theme.bodySmall!.copyWith(
                    color: index == 5 ? AppColors.white : AppColors.blue400,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              itemCount: 9,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
            ),
            SizedBox(
              height: 10.h,
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: RiseButton(
        width: 90.w,
        title: 'Book Appointment',
        onTap: () {},
      ),
    );
  }
}
