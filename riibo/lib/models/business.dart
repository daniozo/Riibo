class Business {
  final int businessId;
  final String name;
  final String description;
  final String address;
  final List<double> coordinates;
  final String contactPhone;
  final String contactEmail;
  final String logoUrl;
  final String openingHours;
  final String closingHours;
  final String businessType;

  Business({
    required this.businessId,
    required this.name,
    required this.description,
    required this.businessType,
    required this.address,
    required this.contactPhone,
    required this.contactEmail,
    required this.logoUrl,
    required this.openingHours,
    required this.closingHours,
    required this.coordinates,
  });

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      businessId: json['business_id'],
      name: json['name'],
      description: json['description'],
      businessType: json['business_type'],
      address: json['address'],
      contactPhone: json['contact_phone'],
      contactEmail: json['contact_email'],
      logoUrl: json['logo_url'],
      openingHours: json['opening_hours'],
      closingHours: json['closing_hours'],
      coordinates: List<double>.from(json['coordinates']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'business_id': businessId,
      'name': name,
      'description': description,
      'business_type': businessType,
      'address': address,
      'contact_phone': contactPhone,
      'contact_email': contactEmail,
      'logo_url': logoUrl,
      'opening_hours': openingHours,
      'closing_hours': closingHours,
      'coordinates': coordinates,
    };
  }
}
