import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:riibo/services/location_service.dart';

import '../models/article.dart';
import '../screens/articles/article_details_screen.dart';

class DiscoverScreenArticleCard extends StatefulWidget {
  final Article article;

  const DiscoverScreenArticleCard({super.key, required this.article});

  @override
  State<DiscoverScreenArticleCard> createState() =>
      _DiscoverScreenArticleCardState();
}

class _DiscoverScreenArticleCardState extends State<DiscoverScreenArticleCard> {
  final LocationService _locationService = LocationService();
  double? _distance;

  @override
  void initState() {
    super.initState();
    _calculateDistance();
  }

  Future<void> _calculateDistance() async {
    List<double> articleLocation =
        widget.article.coordinates; // Assuming coordinates is a List<String>
    double distance = await _getDistance(articleLocation);
    setState(() {
      _distance = distance;
    });
  }

  Future<double> _getDistance(List<double> articleLocation) async {
    Position position = await _locationService.getCurrentLocation();
    LatLng currentPosition = LatLng(position.latitude, position.longitude);
    LatLng targetPosition = LatLng(articleLocation[0], articleLocation[1]);

    return _locationService.calculateDistance(currentPosition, targetPosition);
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> item = widget.article.toJson();

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) =>
                ArticleDetailsScreen(articleId: item['article_id']!.toString()),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22.0),
          color: CupertinoColors.systemOrange.withOpacity(0.1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(22.0),
                topRight: Radius.circular(22.0),
              ),
              child: Image.network(
                item['images'][0]!,
                fit: BoxFit.cover,
                height: 120.0,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                right: 8.0,
                top: 8.0,
              ),
              child: Text(
                item['article_name']!,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 5.0),
            Padding(
              padding:
                  const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      item['business_name']!,
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    _distance != null
                        ? "${_distance!.toStringAsFixed(2)} km"
                        : "Calcul en cours...",
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey,
                    ),
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: "${item['initial_price']!}",
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.lineThrough,
                      ),
                      children: const [
                        TextSpan(
                          text: ' €',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: "${item['sale_price']}",
                      style: const TextStyle(
                        fontSize: 25.0,
                        color: CupertinoColors.systemOrange,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: ' €',
                          style: TextStyle(
                            color:
                                CupertinoColors.systemOrange.withOpacity(0.8),
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Icon(
                  Icons.shopping_basket_outlined,
                  size: 26.0,
                  color: CupertinoColors.black.withOpacity(0.8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
