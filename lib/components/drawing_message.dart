import 'package:flutter/material.dart';

import 'horizontal_lines_background_painter.dart';

class DrawingMessage extends StatelessWidget {
  final String imageLink;
  final String username;
  late final String bucketAddress;

  DrawingMessage({super.key, required this.imageLink, required this.username}) {
   bucketAddress = const String.fromEnvironment('BUCKET_URL');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 2.06),
        borderRadius: BorderRadius.all(Radius.circular(10.29)),
      ),
      child: Stack(
        children: [
          ClipRRect(
            clipBehavior: Clip.hardEdge,
            borderRadius: BorderRadius.vertical(top: Radius.circular(10.29)),
            child: CustomPaint(
              painter: HorizontalLinesBackgroundPainter(
                lineColor: Color(0xFFcacbe1),
                lineWidth: 2,
                spacing: 29,
              ),
              size: Size.infinite,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10.29)),
            clipBehavior: Clip.hardEdge,
            child: AspectRatio(
              aspectRatio: 2,
              child: Image.network(
                alignment: FractionalOffset.topCenter,
                fit: BoxFit.cover,
                bucketAddress + imageLink,
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            width: 100,
            height: 30,
            decoration: BoxDecoration(
              color: Color(0xFFb7baef),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomRight: Radius.circular(10.29),
              ),
              border: Border(
                bottom: BorderSide(color: Color(0xFF0e155b), width: 2),
                right: BorderSide(color: Color(0xFF0e155b), width: 2),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                username,
                style: TextStyle(
                  fontFamily: "Nintendo_DS_BIOS",
                  fontSize: 24.7,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
