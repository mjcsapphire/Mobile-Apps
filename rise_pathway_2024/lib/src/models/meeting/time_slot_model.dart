class TimeSlot {
  final String time;

  TimeSlot({required this.time});

  factory TimeSlot.fromJson(Map<String, dynamic> json) {
    return TimeSlot(time: json['time']);
  }

  Map<String, dynamic> toJson() {
    return {'time': time};
  }

  static List<TimeSlot> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => TimeSlot.fromJson(json)).toList();
  }

  static List<Map<String, dynamic>> toJsonList(List<TimeSlot> timeSlots) {
    return timeSlots.map((timeSlot) => timeSlot.toJson()).toList();
  }
}
