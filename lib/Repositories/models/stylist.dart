import 'package:glowup/Repositories/models/availability_slot.dart';

class Stylist {
  Stylist({
    this.id,
    required this.providerId,
    required this.name,
    this.avgRating,
    this.ratingCount,
    required this.createdAt,
    this.bio,
  });
  late final String? id;
  late final String providerId;
  late final String name;
  late final double? avgRating;
  late final int? ratingCount;
  late final String createdAt;
  late final String? bio;
  List<AvailabilitySlot> availabilitySlots = [];

  Stylist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    providerId = json['provider_id'];
    name = json['name'];
    avgRating = json['avg_rating'];
    ratingCount = json['rating_count'];
    createdAt = json['created_at'];
    bio = json['bio'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['provider_id'] = providerId;
    _data['name'] = name;
    _data['avg_rating'] = avgRating;
    _data['rating_count'] = ratingCount;
    _data['created_at'] = createdAt;
    _data['bio'] = bio;
    return _data;
  }
}
