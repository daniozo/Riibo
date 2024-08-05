import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:riibo/categories.dart';
import 'package:go_router/go_router.dart';
import 'package:riibo/models/article.dart';
import 'package:riibo/services/location_service.dart';
import 'package:riibo/widgets/map_view.dart';
import 'package:riibo/services/article_service.dart';

import '../../provider/connectivity_provider.dart';
import '../../widgets/discover_screen_article_card.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final ArticleService _articleService = ArticleService();
  final LocationService _locationService = LocationService();

  late Future<List<Article>> _articles = _articleService.getRecentArticles();

  final List<Map<String, String>> _categories = riiboCategories;

  final List<String> _filterList = [
    "Tout",
    "< 1km",
    "< 2km",
    "Favoris",
    "Nouveau",
    "Aujourd'hui",
    "Demain",
  ];

  List<int> _selectedFiltersIndexes = [0];

  dynamic _selectedCategoryIndex;
  bool _isCategorySelected(int index) {
    return _selectedCategoryIndex != null && _selectedCategoryIndex != index;
  }

  void _articlesListFuture() {
    if (_selectedCategoryIndex != null || _selectedFiltersIndexes.isNotEmpty) {
      _articles = _articleService.getArticlesByFilters(
        _selectedCategoryIndex == null
            ? 'all'
            : _categories[_selectedCategoryIndex]['name']!,
        within1km: _selectedFiltersIndexes.contains(1),
        within2km: _selectedFiltersIndexes.contains(2),
        newArticles: _selectedFiltersIndexes.contains(3),
        favoriteArticles: _selectedFiltersIndexes.contains(4),
      );
    } else {
      _articles = _articleService.getRecentArticles();
    }
  }

  dynamic _address = {};

  late bool _hasLocationPermission = false;

  @override
  void initState() {
    super.initState();
    _hasGrantedLocationPermission();
    _setAddress();
    _selectedCategoryIndex = null;
    _articles = _articleService.getRecentArticles();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _hasGrantedLocationPermission() async {
    _hasLocationPermission = await _locationService.hasLocationPermission();
  }

  Future<void> _setAddress() async {
    if (await _locationService.hasLocationPermission()) {
      final position = await _locationService.getCurrentLocation();
      final address = await _locationService.getAddress(position);
      setState(() {
        _address = address;
      });
    } else {
      setState(() {
        _address = const Text("Autorisez l'accès à la localisation");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isConnected = Provider.of<ConnectivityProvider>(context).isConnected;

    return _hasLocationPermission
        ? CupertinoPageScaffold(
            backgroundColor: CupertinoColors.white,
            child: SafeArea(
              child: Column(
                children: [
                  Container(
                    height: 80,
                    padding: const EdgeInsets.only(
                      left: 16.0,
                      right: 16.0,
                      top: 20.0,
                      bottom: .0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Emplacement",
                                    style: TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.normal,
                                      color: CupertinoColors.inactiveGray,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4.0,
                                  ),
                                  Icon(
                                    CupertinoIcons.chevron_down,
                                    size: 12.0,
                                    color: CupertinoColors.inactiveGray,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 4.0,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(
                                    CupertinoIcons.location_fill,
                                    size: 15.0,
                                    color: CupertinoColors.systemOrange,
                                  ),
                                  const SizedBox(width: 4.0),
                                  Text(
                                    _address.isNotEmpty
                                        ? '${_address['city']!}, ${_address['country']!}'
                                        : '...',
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w600,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  isConnected
                      ? Expanded(
                          child: CustomScrollView(
                            physics: const ClampingScrollPhysics(),
                            slivers: [
                              const SliverToBoxAdapter(
                                child: SizedBox(height: 20.0),
                              ),
                              SliverToBoxAdapter(
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 16.0, right: 16.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // const SizedBox(height: 20.0),
                                      Expanded(
                                        child: CupertinoTextField(
                                          placeholder:
                                              "Recherche ce qu'il te faut",
                                          placeholderStyle: const TextStyle(
                                            color: CupertinoColors.systemGrey,
                                            fontSize: 14.0,
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0,
                                            vertical: 10.0,
                                          ),
                                          readOnly: true,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            border: Border.all(
                                              color: CupertinoColors.systemGrey,
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(10.0),
                                            ),
                                          ),
                                          onTap: () {}, //TODO
                                        ),
                                      ),
                                      const SizedBox(width: 10.0),
                                      Container(
                                        padding: const EdgeInsets.all(1.0),
                                        child: CupertinoButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: () {
                                            showCupertinoModalPopup(
                                              context: context,
                                              useRootNavigator: true,
                                              builder: (context) => SafeArea(
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.9,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.cyan,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(15.0),
                                                      topRight:
                                                          Radius.circular(15.0),
                                                    ),
                                                  ),
                                                  child: const ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(15.0),
                                                      topRight:
                                                          Radius.circular(15.0),
                                                    ),
                                                    child: MapView(),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          child: const Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                CupertinoIcons.map,
                                                color: CupertinoColors
                                                    .systemOrange,
                                                size: 32.0,
                                              ),
                                              SizedBox(height: 2.0),
                                              Text(
                                                "Voir sur la map",
                                                style: TextStyle(
                                                  fontSize: 11.0,
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SliverToBoxAdapter(
                                child: SizedBox(height: 10.0),
                              ),
                              SliverToBoxAdapter(
                                child: SizedBox(
                                  height: 100.0,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: const ClampingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: _categories.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      bool isSelected =
                                          _selectedCategoryIndex == null ||
                                              _selectedCategoryIndex == index;
                                      return GestureDetector(
                                        onTap: () {
                                          setState(
                                            () {
                                              if (_selectedCategoryIndex ==
                                                  index) {
                                                _selectedCategoryIndex = null;
                                              } else {
                                                _selectedCategoryIndex = index;
                                              }
                                              _articlesListFuture();
                                            },
                                          );
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(
                                            left: (index == 0)
                                                ? 20.0
                                                : (index % 2 != 0)
                                                    ? 20.0
                                                    : 0.0,
                                            right: (index ==
                                                    _filterList.length - 1)
                                                ? 20.0
                                                : (index % 2 == 0)
                                                    ? 0.0
                                                    : 20.0,
                                          ),
                                          width: 69.0,
                                          child: Opacity(
                                            opacity: isSelected ? 1.0 : 0.4,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                  _categories[index]["icon"]!,
                                                  width: 40,
                                                  height: 40,
                                                ),
                                                const SizedBox(
                                                  height: 8.0,
                                                ),
                                                Text(
                                                  _categories[index]["name"]!,
                                                  style: const TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              SliverToBoxAdapter(
                                child: SizedBox(
                                  height: 31.0,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: const ClampingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: _filterList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return GestureDetector(
                                        onTap: () {
                                          setState(
                                            () {
                                              if (index == 0) {
                                                _selectedFiltersIndexes = [0];
                                              } else {
                                                if (_selectedFiltersIndexes
                                                    .contains(index)) {
                                                  _selectedFiltersIndexes
                                                      .remove(index);
                                                } else {
                                                  _selectedFiltersIndexes
                                                      .add(index);
                                                }
                                                if (_selectedFiltersIndexes
                                                    .isEmpty) {
                                                  _selectedFiltersIndexes = [0];
                                                } else if (_selectedFiltersIndexes
                                                    .contains(0)) {
                                                  _selectedFiltersIndexes
                                                      .remove(0);
                                                }
                                              }
                                              _articlesListFuture();
                                            },
                                          );
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(
                                            left: (index == 0)
                                                ? 20.0
                                                : (index % 2 != 0)
                                                    ? 10.0
                                                    : 0.0,
                                            right: (index ==
                                                    _filterList.length - 1)
                                                ? 20.0
                                                : (index % 2 == 0)
                                                    ? 0.0
                                                    : 10.0,
                                          ),
                                          padding: const EdgeInsets.only(
                                              left: 8.0, right: 8.0),
                                          decoration: BoxDecoration(
                                            color: _selectedFiltersIndexes
                                                    .contains(index)
                                                ? CupertinoColors.systemOrange
                                                    .withOpacity(0.7)
                                                : CupertinoColors.systemOrange
                                                    .withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                _filterList[index],
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const SliverToBoxAdapter(
                                child: SizedBox(height: 20.0),
                              ),
                              const SliverPadding(
                                padding:
                                    EdgeInsets.only(left: 16.0, bottom: 10.0),
                                sliver: SliverToBoxAdapter(
                                  child: Text(
                                    "Découvrir",
                                    style: TextStyle(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              SliverPadding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                sliver: FutureBuilder<List<Article>>(
                                  future: _articles,
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const SliverToBoxAdapter(
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                                    } else if (snapshot.hasError) {
                                      return SliverToBoxAdapter(
                                        child: Center(
                                          child:
                                              Text('Erreur: ${snapshot.error}'),
                                        ),
                                      );
                                    } else if (!snapshot.hasData ||
                                        snapshot.data!.isEmpty) {
                                      return SliverToBoxAdapter(
                                        child: Center(
                                          child: Text(
                                              'Aucun article trouvé : ${snapshot.data}'),
                                        ),
                                      );
                                    } else {
                                      List<Article> items =
                                          snapshot.data!.reversed.toList();
                                      return SliverGrid(
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 8.0,
                                          mainAxisSpacing: 8.0,
                                          childAspectRatio: 0.7,
                                        ),
                                        delegate: SliverChildBuilderDelegate(
                                          (BuildContext context, int index) {
                                            Article item = items[index];
                                            return DiscoverScreenArticleCard(
                                              article: item,
                                            );
                                          },
                                          childCount: items.length,
                                        ),
                                      );
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                        )
                      : Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                CupertinoIcons.wifi_slash,
                                color: CupertinoColors.inactiveGray,
                                size: 100.0,
                              ),
                              const SizedBox(height: 20.0),
                              Text(
                                "Hors ligne",
                                style: TextStyle(
                                  color: CupertinoColors.black.withOpacity(0.5),
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              Text(
                                "Vérifie ta connexion internet",
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.9),
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          )
        : CupertinoPageScaffold(
            child: SafeArea(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.location_off,
                      color: CupertinoColors.inactiveGray,
                      size: 100.0,
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      "GPS NON ACTIF",
                      style: TextStyle(
                        color: CupertinoColors.black.withOpacity(0.5),
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      "Active ton GPS, pour afficher les paniers disponsibles",
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.9),
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    CupertinoButton(
                      onPressed: () async {
                        _locationService.requestLocationPermission();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: CupertinoColors.systemOrange.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: const Text(
                          "Activer le GPS",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
