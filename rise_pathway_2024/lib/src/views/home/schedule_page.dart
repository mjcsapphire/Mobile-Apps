import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rise_pathway/core/constants/package_export.dart';
import 'package:rise_pathway/core/helpers/helpers.dart';
import 'package:rise_pathway/core/routes/routes.dart';
import 'package:rise_pathway/core/utils/colors.dart';
import 'package:rise_pathway/src/controllers/auth_controller.dart';
import 'package:rise_pathway/src/controllers/meeting_controller.dart';
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
  final selectedTimeSlot = 0.obs;
  final meetingController = Get.find<MeetingController>();
  final authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    fetchTimeSlots();
  }

  Future<void> fetchTimeSlots() async {
    String formattedDate = DateFormat('yyyy-MM-dd').format(focusDate.value);

    await meetingController.getAvailableTimeSlots(
        email: authController.userData.value.userEmail!, date: formattedDate);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: RiseAppBar.riseAppBar(
        theme: theme,
        title: 'Calendar',
        onTap: () => context.pop(),
        backgroundColor: AppColors.white,
        suffixIcon: Icons.history_rounded,
        suffixOnTap: () {
          context.push(appointment);
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Obx(() {
              return TableCalendar(
                focusedDay: focusDate.value,
                firstDay: DateTime.now(),
                lastDay: DateTime.utc(3000),
                rowHeight: 45,
                daysOfWeekHeight: 45,
                onDaySelected: (selectedDay, focusedDay) {
                  focusDate.value = selectedDay;
                  fetchTimeSlots();
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
                  todayDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    shape: BoxShape.rectangle,
                    color: AppColors.blue400,
                  ),
                  selectedDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    shape: BoxShape.rectangle,
                    color: AppColors.blue600,
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
              );
            }),
            SizedBox(height: 2.h),
            Align(
              alignment: Alignment.centerLeft,
              child: RiseText(
                'Available Times',
                style: theme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(height: 2.h),

            // Show loading indicator
            Obx(() {
              if (meetingController.isLoading.value) {
                return Padding(
                  padding: EdgeInsets.only(top: 5.h),
                  child: const Center(child: CircularProgressIndicator()),
                );
              }
              if (meetingController.timeSlots.isEmpty) {
                return Center(
                    child: Padding(
                  padding: EdgeInsets.only(top: 3.h),
                  child: const RiseText("No available slots"),
                ));
              }

              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 16,
                  mainAxisExtent: 48,
                ),
                itemCount: meetingController.timeSlots.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => Obx(
                  () => GestureDetector(
                    onTap: () {
                      selectedTimeSlot.value = index;
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.black.withOpacity(0.03),
                        ),
                        borderRadius: BorderRadius.circular(10),
                        color: index == selectedTimeSlot.value
                            ? AppColors.blue600
                            : AppColors.white,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.black.withOpacity(0.02),
                            blurRadius: 12,
                          )
                        ],
                      ),
                      child: RiseText(
                        meetingController.timeSlots[index].time
                            .split(':')
                            .sublist(0, 2)
                            .join(':'),
                        style: theme.bodySmall!.copyWith(
                          color: index == selectedTimeSlot.value
                              ? AppColors.white
                              : AppColors.blue400,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
            SizedBox(height: 10.h),
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
