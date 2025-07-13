import 'package:glowup/Repositories/models/provider.dart';
import 'package:glowup/Repositories/models/stylist.dart';

class Services {
  Services({
    this.id,
    required this.name,
    required this.description,
    required this.durationMinutes,
    required this.price,
    required this.category,
    required this.providerId,
  });
  late final int? id;
  late String name;
  late String description;
  late int durationMinutes;
  late double price;
  late final String providerId;
  late String imageUrl;
  late final String category;
  late bool atHome;
  List<Stylist> stylists = [];
  Provider? provider;

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    durationMinutes = json['duration_minutes'];
    price = json['price'];
    providerId = json['provider_id'];
    imageUrl = json['image_url'] ?? '';
    category = json['category'] ?? '';
    atHome = json['at_home'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['description'] = description;
    _data['duration_minutes'] = durationMinutes;
    _data['price'] = price;
    _data['provider_id'] = providerId;
    _data['category'] = category;
    _data['at_home'] = atHome;
    return _data;
  }
}
