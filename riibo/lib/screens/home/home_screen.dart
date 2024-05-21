import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:riibo/widgets/home_meal_banner.dart';

import '../../services/location_service.dart';

class HomeScreen extends StatefulWidget {
  final CupertinoTabController tabController;

  const HomeScreen({Key? key, required this.tabController}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LocationService _locationService = LocationService();
  dynamic _address = {};

  @override
  void initState() {
    super.initState();
    _setAddress();
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
    List<Widget> items = <Widget>[
      const SizedBox(
        height: 20.0,
      ),
      Container(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Bonjour John 😎",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 22.0,
                height: 1.3,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              "Trouve et sauve des aliments 🍉 sur Riibo",
              style: TextStyle(
                color: Colors.black,
                // fontWeight: FontWeight.bold,
                fontSize: 16.0,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
      const SizedBox(
        height: 30.0,
      ),
      Container(
        // height: 250.0,
        margin: const EdgeInsets.only(left: 16.0, right: 16.0),
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: CupertinoColors.systemOrange.withOpacity(0.75),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  "Que des paniers à\nsauver à l'horizon",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  "Profite de plus de 250\ncommerces à proximité",
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
                const SizedBox(height: 15.0),
                GestureDetector(
                  onTap: () {
                    Future.delayed(
                      const Duration(milliseconds: 100),
                      () => widget.tabController.index = 1,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: const Text(
                      "Découvrir",
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
            const SizedBox(width: 10),
            Expanded(
              child: Image.asset("assets/discover.png"),
            )
          ],
        ),
      ),
      const SizedBox(
        height: 40.0,
      ),
      // Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   // mainAxisSize: MainAxisSize.min,
      //   children: [
      //     const Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: [
      //         Text(
      //           "Aujourd'hui",
      //           style: TextStyle(
      //             color: Colors.black,
      //             fontWeight: FontWeight.bold,
      //             fontSize: 19.0,
      //             height: 1.3,
      //           ),
      //         ),
      //         Icon(
      //           CupertinoIcons.chevron_right,
      //           color: CupertinoColors.systemOrange,
      //         ),
      //       ],
      //     ),
      //     // const SizedBox(
      //     //   height: 5.0,
      //     // ),
      //     SizedBox(
      //       height: 250.0,
      //       child: ListView.builder(
      //         scrollDirection: Axis.horizontal,
      //         itemCount: 5,
      //         itemBuilder: (BuildContext context, int index) {
      //           return const HomeMealBanner();
      //         },
      //         // children: <Widget>[
      //         // const SizedBox(
      //         //   width: 10.0,
      //         // ),
      //         // ],
      //       ),
      //     ),
      //   ],
      // ),
      // const SizedBox(
      //   height: 50.0,
      // ),
      // Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   // mainAxisSize: MainAxisSize.min,
      //   children: [
      //     const Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: [
      //         Text(
      //           "De tes commerces préférés",
      //           style: TextStyle(
      //             color: Colors.black,
      //             fontWeight: FontWeight.bold,
      //             fontSize: 19.0,
      //             height: 1.3,
      //           ),
      //         ),
      //         Icon(
      //           CupertinoIcons.chevron_right,
      //           color: CupertinoColors.systemOrange,
      //         ),
      //       ],
      //     ),
      //     // const SizedBox(
      //     //   height: 5.0,
      //     // ),
      //     SizedBox(
      //       height: 250.0,
      //       child: ListView.builder(
      //         scrollDirection: Axis.horizontal,
      //         itemCount: 5,
      //         itemBuilder: (BuildContext context, int index) {
      //           return const HomeMealBanner();
      //         },
      //         // children: <Widget>[
      //         // const SizedBox(
      //         //   width: 10.0,
      //         // ),
      //         // ],
      //       ),
      //     ),
      //   ],
      // ),
      // const SizedBox(
      //   height: 50.0,
      // ),
      // Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   // mainAxisSize: MainAxisSize.min,
      //   children: [
      //     const Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: [
      //         Text(
      //           "Nouveau sur Riibo",
      //           style: TextStyle(
      //             color: Colors.black,
      //             fontWeight: FontWeight.bold,
      //             fontSize: 19.0,
      //             height: 1.3,
      //           ),
      //         ),
      //         Icon(
      //           CupertinoIcons.chevron_right,
      //           color: CupertinoColors.systemOrange,
      //         ),
      //       ],
      //     ),
      //     SizedBox(
      //       height: 250.0,
      //       child: ListView.builder(
      //         scrollDirection: Axis.horizontal,
      //         itemCount: 5,
      //         itemBuilder: (BuildContext context, int index) {
      //           return const HomeMealBanner();
      //         },
      //       ),
      //     ),
      //   ],
      // ),
      // const SizedBox(
      //   height: 50.0,
      // ),
      // Container(
      //   padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     // mainAxisSize: MainAxisSize.min,
      //     children: [
      //       const Text(
      //         "Par catégorie",
      //         style: TextStyle(
      //           color: Colors.black,
      //           fontWeight: FontWeight.bold,
      //           fontSize: 19.0,
      //           height: 1.3,
      //         ),
      //       ),
      //       const SizedBox(
      //         height: 20.0,
      //       ),
      //       Column(
      //         children: [
      //           Row(
      //             crossAxisAlignment: CrossAxisAlignment.center,
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               Expanded(
      //                 child: Container(
      //                   margin: const EdgeInsets.all(5.0),
      //                   width: 100.0,
      //                   height: 100.0,
      //                   decoration: BoxDecoration(
      //                     borderRadius: BorderRadius.circular(15.0),
      //                     color: CupertinoColors.systemOrange.withOpacity(0.4),
      //                   ),
      //                   child: Column(
      //                     mainAxisAlignment: MainAxisAlignment.center,
      //                     children: [
      //                       SvgPicture.asset(
      //                         'assets/resto.svg',
      //                         width: 42,
      //                         height: 42,
      //                       ),
      //                       const SizedBox(
      //                         height: 6.0,
      //                       ),
      //                       const Text(
      //                         "Restaurant",
      //                         style: TextStyle(
      //                           overflow: TextOverflow.ellipsis,
      //                           fontSize: 12,
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //               Expanded(
      //                 child: Container(
      //                   margin: const EdgeInsets.all(5.0),
      //                   width: 100.0,
      //                   height: 100.0,
      //                   decoration: BoxDecoration(
      //                     borderRadius: BorderRadius.circular(15.0),
      //                     color: CupertinoColors.systemOrange.withOpacity(0.4),
      //                   ),
      //                   child: Column(
      //                     mainAxisAlignment: MainAxisAlignment.center,
      //                     children: [
      //                       SvgPicture.asset(
      //                         'assets/store.svg',
      //                         width: 42,
      //                         height: 42,
      //                       ),
      //                       const SizedBox(
      //                         height: 6.0,
      //                       ),
      //                       const Text(
      //                         "Supermaché",
      //                         style: TextStyle(
      //                           overflow: TextOverflow.ellipsis,
      //                           fontSize: 12,
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //               Expanded(
      //                 child: Container(
      //                   padding: const EdgeInsets.all(5.0),
      //                   margin: const EdgeInsets.all(5.0),
      //                   width: 100.0,
      //                   height: 100.0,
      //                   decoration: BoxDecoration(
      //                     borderRadius: BorderRadius.circular(15.0),
      //                     color: CupertinoColors.systemOrange.withOpacity(0.4),
      //                   ),
      //                   child: Column(
      //                     mainAxisAlignment: MainAxisAlignment.center,
      //                     children: [
      //                       SvgPicture.asset(
      //                         'assets/croissant.svg',
      //                         width: 42,
      //                         height: 42,
      //                       ),
      //                       const SizedBox(
      //                         height: 6.0,
      //                       ),
      //                       const Text(
      //                         "Boulangerie et pâtisserie",
      //                         style: TextStyle(
      //                           overflow: TextOverflow.ellipsis,
      //                           fontSize: 12,
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //             ],
      //           ),
      //           Row(
      //             crossAxisAlignment: CrossAxisAlignment.center,
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               Expanded(
      //                 child: Container(
      //                   margin: const EdgeInsets.all(5.0),
      //                   width: 100.0,
      //                   height: 100.0,
      //                   decoration: BoxDecoration(
      //                     borderRadius: BorderRadius.circular(15.0),
      //                     color: CupertinoColors.systemOrange.withOpacity(0.4),
      //                   ),
      //                   child: Column(
      //                     mainAxisAlignment: MainAxisAlignment.center,
      //                     children: [
      //                       SvgPicture.asset(
      //                         'assets/fruit.svg',
      //                         width: 42,
      //                         height: 42,
      //                       ),
      //                       const SizedBox(
      //                         height: 6.0,
      //                       ),
      //                       const Text(
      //                         "Fruits et légumes",
      //                         style: TextStyle(
      //                           overflow: TextOverflow.ellipsis,
      //                           fontSize: 12,
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //               Expanded(
      //                 child: Container(
      //                   margin: const EdgeInsets.all(5.0),
      //                   width: 100.0,
      //                   height: 100.0,
      //                   decoration: BoxDecoration(
      //                     borderRadius: BorderRadius.circular(15.0),
      //                     color: CupertinoColors.systemOrange.withOpacity(0.4),
      //                   ),
      //                   child: Column(
      //                     mainAxisAlignment: MainAxisAlignment.center,
      //                     children: [
      //                       SvgPicture.asset(
      //                         'assets/burger.svg',
      //                         width: 42,
      //                         height: 42,
      //                       ),
      //                       const SizedBox(
      //                         height: 6.0,
      //                       ),
      //                       const Text(
      //                         "Fast food",
      //                         style: TextStyle(
      //                           overflow: TextOverflow.ellipsis,
      //                           fontSize: 12,
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //               Expanded(
      //                 child: Container(
      //                   margin: const EdgeInsets.all(5.0),
      //                   width: 100.0,
      //                   height: 100.0,
      //                   decoration: BoxDecoration(
      //                     borderRadius: BorderRadius.circular(15.0),
      //                     color: CupertinoColors.systemOrange.withOpacity(0.4),
      //                   ),
      //                   child: Column(
      //                     mainAxisAlignment: MainAxisAlignment.center,
      //                     children: [
      //                       SvgPicture.asset(
      //                         'assets/drink.svg',
      //                         width: 42,
      //                         height: 42,
      //                       ),
      //                       const SizedBox(
      //                         height: 6.0,
      //                       ),
      //                       const Text(
      //                         "Boissons",
      //                         style: TextStyle(
      //                           overflow: TextOverflow.ellipsis,
      //                           fontSize: 12,
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //             ],
      //           ),
      //           // const SizedBox(height: 50.0),
      //           // Container(),
      //         ],
      //       ),
      //       const SizedBox(height: 50.0),
      //     ],
      //   ),
      // ),
    ];

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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [                         const Row(
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
                  const Icon(
                    CupertinoIcons.bell,
                    color: CupertinoColors.black,
                    size: 25.0,
                  ),
                  const SizedBox(width: 15.0),
                  Container(
                    padding: const EdgeInsets.all(1.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      border: Border.all(
                        color: CupertinoColors.systemOrange,
                        width: 1.0,
                      ),
                    ),
                    child: const CircleAvatar(
                      backgroundColor: CupertinoColors.systemOrange,
                      child: ClipOval(
                        child: Image(
                          image: NetworkImage("https://i.pravatar.cc/300"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  return items[index];
                },
                physics: const ClampingScrollPhysics(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
