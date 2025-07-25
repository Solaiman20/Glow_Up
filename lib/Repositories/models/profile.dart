class Profile {
  Profile({
    required this.id,
    required this.fullName,
    this.phone,
    this.username,
    required this.role,
    this.latitude,
    this.longitude,
    this.mapsUrl,
  });
  late final String id;
  late String fullName;
  late String? phone;
  late String? username;
  late final String role;
  late double? latitude;
  late double? longitude;
  late double? avgRating;
  String? avatarUrl;
  late final String? mapsUrl;
  List<String> ratings = [];

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    phone = json['phone'] as String?;
    username = json['username'] as String?;
    role = json['role'];
    latitude = json['latitude'] as double?;
    longitude = json['longitude'] as double?;
    avatarUrl = json['avatar_url'] ?? '';
    mapsUrl = json['maps_url'] as String?;
    avgRating = json['avg_rating'] as double?;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['full_name'] = fullName;
    _data['phone'] = phone;
    _data['username'] = username;
    _data['role'] = role;
    _data['latitude'] = latitude;
    _data['longitude'] = longitude;
    _data['avatar_url'] = avatarUrl ?? "";
    _data['maps_url'] = mapsUrl;
    _data['avg_rating'] = avgRating;
    return _data;
  }
}
