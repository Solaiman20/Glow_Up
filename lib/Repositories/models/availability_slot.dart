class AvailabilitySlot {
  AvailabilitySlot({
    this.id,
    required this.stylistId,
    required this.startTime,
    required this.endTime,
    required this.date,
  });
  late final int? id;
  late final String stylistId;
  late String startTime;
  late String endTime;
  late String date;

  AvailabilitySlot.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stylistId = json['stylist_id'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['stylist_id'] = stylistId;
    _data['start_time'] = startTime;
    _data['end_time'] = endTime;
    _data['date'] = date;
    return _data;
  }
}
