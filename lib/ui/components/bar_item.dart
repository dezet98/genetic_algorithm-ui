import 'package:flutter/widgets.dart';

abstract class TabItem extends StatelessWidget {
  String getLabel(BuildContext context);
  Widget getIcon(BuildContext context);

  BottomNavigationBarItem bottomBarItem(BuildContext context) {
    return BottomNavigationBarItem(
        icon: getIcon(context), label: getLabel(context));
  }
}
