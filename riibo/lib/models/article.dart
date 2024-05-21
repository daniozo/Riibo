class Article {
  final int articleId;
  final String businessId;
  final String businessName;
  final String articleName;
  final String articleDescription;
  final double initialPrice;
  final double salePrice;
  final int quantity;
  final DateTime createdAt;
  final DateTime availableUntil;
  final String status;
  final List<String> images;
  final List<double> coordinates;

  Article({
    required this.articleId,
    required this.articleName,
    required this.businessName,
    required this.articleDescription,
    required this.initialPrice,
    required this.salePrice,
    required this.quantity,
    required this.createdAt,
    required this.availableUntil,
    required this.status,
    required this.images,
    required this.businessId,
    required this.coordinates,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    List<double> coordinates;

    if (json['coordinates'] is String) {
      String pointStr = json['coordinates'];
      pointStr = pointStr.replaceAll("POINT(", "").replaceAll(")", "");
      List<String> latLngStr = pointStr.split(" ");
      coordinates = [double.parse(latLngStr[0]), double.parse(latLngStr[1])];
    } else if (json['coordinates'] is List) {
      coordinates = List<double>.from(json['coordinates']);
    } else if (json['coordinates'] is Map &&
        json['coordinates']['type'] == 'Point') {
      coordinates = List<double>.from(json['coordinates']['coordinates']);
    } else {
      throw const FormatException("Invalid format for coordinates");
    }

    return Article(
      articleId: json['article_id'],
      articleName: json['name'],
      articleDescription: json['description'],
      initialPrice: double.parse(json['initial_price'].toString()),
      salePrice: double.parse(json['sale_price'].toString()),
      quantity: json['quantity'],
      createdAt: DateTime.parse(json['created_at']),
      availableUntil: DateTime.parse(json['available_until']),
      status: json['status'],
      images: List<String>.from(json['images']),
      businessId: json['business_id'].toString(),
      coordinates: coordinates,
      businessName: json['business_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'article_id': articleId,
      'article_name': articleName,
      'article_description': articleDescription,
      'initial_price': initialPrice,
      'sale_price': salePrice,
      'quantity': quantity,
      'created_at': createdAt.toIso8601String(),
      'available_until': availableUntil.toIso8601String(),
      'status': status,
      'images': images,
      'business_id': businessId,
      'coordinates': coordinates,
      'business_name': businessName
    };
  }
}
