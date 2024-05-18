import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeMealBanner extends StatelessWidget {
  const HomeMealBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        right: 16.0,
        top: 16.0,
        bottom: 16.0,
      ),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: CupertinoColors.systemOrange,
        borderRadius: BorderRadius.circular(20.0),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.15),
        //     spreadRadius: 1,
        //     blurRadius: 5,
        //   ),
        // ],
      ),
      child: Row(
        // mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const ClipRRect(
            // borderRadius: BorderRadius.circular(5.0),
            child: Image(
              image: NetworkImage(
                "https://static.vecteezy.com/system/resources/thumbnails/021/952/563/small_2x/tasty-hamburger-on-transparent-background-png.png",
                scale: 1.5,
              ),
            ),
          ),
          const SizedBox(
            width: 15.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "5km",
                style: TextStyle(
                  color: Colors.grey[900],
                  fontSize: 15.0,
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              const Text(
                "Hamburger",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "Patisserie Dorée",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
               Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "50 MAD",
                    style: TextStyle(
                      color: Colors.grey[900],
                      fontSize: 14.0,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  const Text(
                    "35 MAD",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
