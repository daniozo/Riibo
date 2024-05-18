import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:riibo/categories.dart';
import 'package:go_router/go_router.dart';
import 'package:riibo/screens/articles/article_details_screen.dart';
import 'package:riibo/widgets/map_view.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final List<Map<String, String>> categories = riiboCategories;
  final List<String> filterList = [
    "Tout",
    "< 1km",
    "< 2km",
    "Favoris",
    "Nouveau",
    "Aujourd'hui",
    "Demain",
  ];
  List<int> selectedFiltersIndexes = [0];

  dynamic selectedCategoryIndex;
  bool isCategorySelected(int index) {
    return selectedCategoryIndex != null && selectedCategoryIndex != index;
  }

  final filteredItems = [
    {
      "id": "1",
      "imageUrl":
          "https://www.foodiesfeed.com/wp-content/uploads/2023/08/sushi-roll-macro.jpg",
      "price": "10",
      "name": "Article",
    },
    {
      "id": "1",
      "imageUrl":
          "https://www.foodiesfeed.com/wp-content/uploads/2023/08/sushi-roll-macro.jpg",
      "price": "10",
      "name": "Article",
    },
    {
      "id": "1",
      "imageUrl":
          "https://www.foodiesfeed.com/wp-content/uploads/2023/08/sushi-roll-macro.jpg",
      "price": "10",
      "name": "Article",
    },
    {
      "id": "1",
      "imageUrl":
          "https://www.foodiesfeed.com/wp-content/uploads/2023/08/sushi-roll-macro.jpg",
      "price": "10",
      "name": "Article",
    },
    {
      "id": "1",
      "imageUrl":
          "https://www.foodiesfeed.com/wp-content/uploads/2023/08/sushi-roll-macro.jpg",
      "price": "10",
      "name": "Article",
    },
  ];

  @override
  void didUpdateWidget(covariant DiscoverScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      selectedCategoryIndex = null;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
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
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Emplacement",
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.normal,
                              color: CupertinoColors.inactiveGray,
                            ),
                          ),
                          SizedBox(
                            width: 4.0,
                          ),
                          Icon(
                            CupertinoIcons.chevron_down,
                            size: 14.0,
                            color: CupertinoColors.systemOrange,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            CupertinoIcons.location_fill,
                            size: 15.0,
                            color: CupertinoColors.systemOrange,
                          ),
                          SizedBox(width: 4.0),
                          Text(
                            "Casablanca, Maroc",
                            style: TextStyle(
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
          Expanded(
            child: CustomScrollView(
              physics: const ClampingScrollPhysics(),
              slivers: [
                const SliverToBoxAdapter(
                  child: SizedBox(height: 20.0),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // const SizedBox(height: 20.0),
                        Expanded(
                          child: CupertinoTextField(
                            placeholder: "Recherche ce qu'il te faut",
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
                              borderRadius: const BorderRadius.all(
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
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        0.9,
                                    decoration: const BoxDecoration(
                                      color: Colors.cyan,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15.0),
                                        topRight: Radius.circular(15.0),
                                      ),
                                    ),
                                    child: const ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15.0),
                                        topRight: Radius.circular(15.0),
                                      ),
                                      child: MapView(),
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  CupertinoIcons.map,
                                  color: CupertinoColors.systemOrange,
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
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 100.0,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (BuildContext context, int index) {
                        bool isSelected = selectedCategoryIndex == null ||
                            selectedCategoryIndex == index;
                        return GestureDetector(
                          onTap: () {
                            setState(
                              () {
                                if (selectedCategoryIndex == index) {
                                  selectedCategoryIndex = null;
                                } else {
                                  selectedCategoryIndex = index;
                                }
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
                              right: (index == filterList.length - 1)
                                  ? 20.0
                                  : (index % 2 == 0)
                                      ? 0.0
                                      : 20.0,
                            ),
                            width: 69.0,
                            child: Opacity(
                              opacity: isSelected ? 1.0 : 0.4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    categories[index]["icon"]!,
                                    width: 40,
                                    height: 40,
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  Text(
                                    categories[index]["name"]!,
                                    style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
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
                      itemCount: filterList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            setState(
                              () {
                                if (index == 0) {
                                  selectedFiltersIndexes = [0];
                                } else {
                                  if (selectedFiltersIndexes.contains(index)) {
                                    selectedFiltersIndexes.remove(index);
                                  } else {
                                    selectedFiltersIndexes.add(index);
                                  }
                                  if (selectedFiltersIndexes.isEmpty) {
                                    selectedFiltersIndexes = [0];
                                  } else if (selectedFiltersIndexes
                                      .contains(0)) {
                                    selectedFiltersIndexes.remove(0);
                                  }
                                }
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
                              right: (index == filterList.length - 1)
                                  ? 20.0
                                  : (index % 2 == 0)
                                      ? 0.0
                                      : 10.0,
                            ),
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            decoration: BoxDecoration(
                              color: selectedFiltersIndexes.contains(index)
                                  ? CupertinoColors.systemOrange
                                      .withOpacity(0.7)
                                  : CupertinoColors.systemOrange
                                      .withOpacity(0.3),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  filterList[index],
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
                  child: SizedBox(height: 25.0),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 5.0,
                      childAspectRatio: 0.7,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        final item = filteredItems[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => ArticleDetailsScreen(
                                    articleId: item["id"]!),
                              ),
                            );
                          },
                          child: Card(
                            elevation: .0,
                            color: CupertinoColors.systemOrange.withOpacity(0.08),
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22.0),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  item['imageUrl']!,
                                  fit: BoxFit.cover,
                                  height: 120.0,
                                  width: double.infinity,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    item['name']!,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    'Prix : ${item['price']} €',
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      childCount: filteredItems.length,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
