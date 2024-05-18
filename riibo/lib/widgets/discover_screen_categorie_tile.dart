import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class DiscoverScreenCategorieTile extends StatelessWidget {
  final String categoryName;
  final String iconPath;

  const DiscoverScreenCategorieTile({
    super.key,
    required this.categoryName,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10.0),
      width: 64.0,
      // decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(15.0),
        // color: CupertinoColors.systemOrange.withOpacity(0.4),
      // ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            iconPath,
            width: 40,
            height: 40,
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            categoryName,
            style: const TextStyle(
              overflow: TextOverflow.ellipsis,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
