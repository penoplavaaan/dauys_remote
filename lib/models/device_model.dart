class Device {
  final String id;
  final String name;
  final DateTime connectedAt;

  Device({
    required this.id,
    this.name = 'Dauys Karaoke Box',
    required this.connectedAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'connectedAt': connectedAt.toIso8601String(),
  };

  factory Device.fromJson(Map<String, dynamic> json) => Device(
    id: json['id'],
    name: json['name'],
    connectedAt: DateTime.parse(json['connectedAt']),
  );
} 