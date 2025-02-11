class ChargingStation {
  final String id;
  final String name;
  final String address;
  final String status;
  bool isFavorite;
  final String connectorType;
  final String pricePerKwh;

  ChargingStation({
    required this.id,
    required this.name,
    required this.address,
    required this.status,
    this.isFavorite = false,
    required this.connectorType,
    required this.pricePerKwh,
  });

  factory ChargingStation.fromJson(Map<String, dynamic> json) {
    return ChargingStation(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      status: json['status'],
      connectorType: json['connectorType'],
      pricePerKwh: json['pricePerKwh'],
    );
  }
}
