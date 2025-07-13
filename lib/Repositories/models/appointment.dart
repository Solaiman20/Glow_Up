import 'package:glowup/Repositories/models/provider.dart';
import 'package:glowup/Repositories/models/services.dart';
import 'package:glowup/Repositories/models/stylist.dart';

class Appointment {
  Appointment({
    this.id,
    required this.customerId,
    required this.stylistId,
    required this.serviceId,
    required this.bookedAt,
    required this.appointmentDate,
    required this.appointmentStart,
    required this.appointmentEnd,
    required this.status,
    required this.atHome,
    required this.providerId,
  });
  late final int? id;
  late final String customerId;
  late final String stylistId;
  late final int serviceId;
  late final String bookedAt;
  late final String appointmentDate;
  late final String appointmentStart;
  late final String appointmentEnd;
  late final String status;
  late final bool atHome;
  late final String providerId;
  Provider? provider;
  Stylist? stylist;
  Services? service;

  Appointment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    stylistId = json['stylist_id'];
    serviceId = json['service_id'];
    bookedAt = json['booked_at'];
    appointmentDate = json['appointment_date'];
    appointmentStart = json['appointment_start'];
    appointmentEnd = json['appointment_end'];
    status = json['status'];
    atHome = json['at_home'];
    providerId = json['provider_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['customer_id'] = customerId;
    _data['stylist_id'] = stylistId;
    _data['service_id'] = serviceId;
    _data['booked_at'] = bookedAt;
    _data['appointment_date'] = appointmentDate;
    _data['appointment_start'] = appointmentStart;
    _data['appointment_end'] = appointmentEnd;
    _data['status'] = status;
    _data['at_home'] = atHome;
    _data['provider_id'] = providerId;
    return _data;
  }
}
