import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WhoAmIAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String label;
  final String imgProvider;

  const WhoAmIAppBar({
    super.key,
    required this.title,
    required this.label,
    required this.imgProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: SvgPicture.asset(imgProvider, height: 21),
                ),
              ],
            ),
            Text(
              label,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
