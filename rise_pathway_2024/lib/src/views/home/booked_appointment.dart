import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rise_pathway/core/constants/package_export.dart';
import 'package:rise_pathway/core/helpers/helpers.dart';
import 'package:rise_pathway/core/utils/colors.dart';
import 'package:rise_pathway/src/controllers/auth_controller.dart';
import 'package:rise_pathway/src/controllers/meeting_controller.dart';
import 'package:rise_pathway/src/views/widget/app_bar.dart';
import 'package:rise_pathway/src/views/widget/rise_button.dart';
import 'package:table_calendar/table_calendar.dart';

class BookedAppointment extends StatefulWidget {
  const BookedAppointment({super.key});

  @override
  State<BookedAppointment> createState() => _BookedAppointmentState();
}

class _BookedAppointmentState extends State<BookedAppointment> {
  final focusDate = DateTime.now().obs;
  final selectedTimeSlot = 0.obs;

  final meetingController = Get.find<MeetingController>();
  final authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getBookings();
      filterMeetingsByDate();
    });
  }

  Future<void> getBookings() async {
    await meetingController.getBookings(
        email: authController.userData.value.userEmail!);
    filterMeetingsByDate();
  }

  void filterMeetingsByDate() {
    String selectedDate = DateFormat('yyyy-MM-dd').format(focusDate.value);
    meetingController.filteredMeetings.value = meetingController.meetings
        .where((meeting) =>
            isSameDay(meeting.dateBooked, DateTime.parse(selectedDate)))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: RiseAppBar.riseAppBar(
        theme: Theme.of(context).textTheme,
        title: 'My Appointments',
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
                  filterMeetingsByDate();
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
                  markerDecoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
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
                  // markerDecoration: Helpers.calendarDecoration,
                  withinRangeDecoration: Helpers.calendarDecoration,
                ),
              );
            }),
            SizedBox(height: 2.h),
            Align(
              alignment: Alignment.centerLeft,
              child: RiseText(
                'Appointment Times',
                style: theme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 2.h),
            meetingController.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(color: AppColors.blue600),
                  )
                : meetingController.filteredMeetings.isEmpty
                    ? Center(
                        child: RiseText(
                          "No meetings today",
                          style: theme.bodyMedium!
                              .copyWith(color: AppColors.blue600),
                        ),
                      )
                    : GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 16,
                          mainAxisExtent: 48,
                        ),
                        itemCount: meetingController.filteredMeetings.length,
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
                                meetingController
                                    .filteredMeetings[index].timeBooked
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
                      ),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: meetingController.filteredMeetings.isEmpty
          ? null
          : RiseButton(
              width: 90.w,
              title: 'Cancel Appointment',
              onTap: () async {
                if (meetingController.filteredMeetings.isNotEmpty) {
                  final selectedMeeting = meetingController
                      .filteredMeetings[selectedTimeSlot.value];

                  await meetingController.cancelMeeting(
                    email: authController.userData.value.userEmail!,
                    id: int.parse(selectedMeeting.id),
                  );
                  print(selectedMeeting.id);

                  // Refresh bookings after cancellation
                  await getBookings();
                }
              },
            ),
    );
  }
}
