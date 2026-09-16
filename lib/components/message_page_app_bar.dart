import 'package:flutter/material.dart';
import 'package:wifi_signal_strength_indicator/wifi_signal_strength_indicator.dart';

class MessagePageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MessagePageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    Future<int?> internetConnection = WifiSignalStrength.getSignalStrength();

    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              spacing: 15,
              children: [
                // Close button
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6.0,
                    vertical: 4.0,
                  ),
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Stack(
                      alignment: AlignmentGeometry.center,
                      children: [
                        Container(
                          height: 32,
                          width: 32,
                          color: Color(0xFF8C908F),
                        ),
                        Container(
                          height: 27,
                          width: 27,
                          decoration: BoxDecoration(
                            color: Color(0xFF8C908F),
                            border: Border.all(
                              color: Color(0xFF474747),
                              width: 2.12,
                            ),
                          ),
                          child: Icon(
                            Icons.close,
                            color: Color(0xFF474747),
                            size: 22.8,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // vertical bars
                Row(
                  spacing: 4,
                  children: [
                    Container(
                      width: 4,
                      height: 27,
                      color: Colors.blue.withAlpha(150),
                    ),
                    Container(
                      width: 4,
                      height: 27,
                      color: Colors.blue.withAlpha(150),
                    ),
                    Container(
                      width: 4,
                      height: 27,
                      color: Colors.blue.withAlpha(150),
                    ),
                    Container(
                      width: 4,
                      height: 27,
                      color: Colors.grey.withAlpha(150),
                    ),
                    Container(
                      width: 4,
                      height: 27,
                      color: Colors.grey.withAlpha(150),
                    ),
                    Container(
                      width: 4,
                      height: 27,
                      color: Colors.grey.withAlpha(150),
                    ),
                    Container(
                      width: 4,
                      height: 27,
                      color: Colors.grey.withAlpha(150),
                    ),
                    Container(
                      width: 4,
                      height: 27,
                      color: Colors.grey.withAlpha(150),
                    ),
                    Container(
                      width: 4,
                      height: 27,
                      color: Colors.grey.withAlpha(150),
                    ),
                    Container(
                      width: 4,
                      height: 27,
                      color: Colors.grey.withAlpha(150),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 6.0,
                vertical: 4.0,
              ),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(width: 32, height: 32, color: Colors.black),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: FutureBuilder(
                      future: internetConnection,
                      builder: (context, asyncSnapshot) {
                        int bars = asyncSnapshot.data != null ? (asyncSnapshot.data! + 100) ~/ 10 : 3;
                        return Row(
                          spacing: 2,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            for (int i = 0; i < bars; i++)
                              Container(
                                width: 4,
                                height: i * 5,
                                color: Colors.white,
                              ),
                          ],
                        );
                      }
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);
}
