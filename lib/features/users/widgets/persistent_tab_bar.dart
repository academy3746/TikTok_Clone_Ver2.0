import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../constants/sizes.dart';
import '../../../utility.dart';

class PersistentTabBar extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final darkMode = isDarkMode(context);

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).appBarTheme.backgroundColor,
        border: Border.symmetric(
            horizontal: BorderSide(
              color: darkMode ? Colors.grey.shade700 : Colors.grey.shade200,
              width: 0.5,
            )),
      ),
      child: TabBar(
        indicatorColor: Theme.of(context).tabBarTheme.indicatorColor,
        indicatorSize: TabBarIndicatorSize.label,
        labelPadding: const EdgeInsets.symmetric(
          vertical: Sizes.size10,
        ),
        tabs: const [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Sizes.size20,
            ),
            child: Icon(
              Icons.grid_4x4_rounded,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Sizes.size20,
            ),
            child: FaIcon(
              FontAwesomeIcons.heart,
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 47;

  @override
  double get minExtent => 47;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}