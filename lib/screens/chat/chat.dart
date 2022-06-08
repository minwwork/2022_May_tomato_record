import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

const roundedCorner = Radius.circular(20);

class Chat extends StatelessWidget {
  final Size size;
  final bool isMine;

  const Chat({Key? key, required this.size, required this.isMine})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isMine ? _buildMyMsg() : _buildOthersMsg();
  }

  Row _buildOthersMsg() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ExtendedImage.network(
          'https://picsum.photos/50',
          width: 40,
          height: 40,
          fit: BoxFit.cover,
          borderRadius: BorderRadius.circular(6),
          shape: BoxShape.rectangle,
        ),
        SizedBox(
          width: 6,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: Text('blar blar blar'),
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              constraints:
                  BoxConstraints(minHeight: 40, maxWidth: size.width * 0.6),
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.only(
                      topRight: roundedCorner,
                      topLeft: Radius.circular(2),
                      bottomRight: roundedCorner)),
            ),
            SizedBox(
              width: 6,
            ),
            Text('오전 10:25'),
          ],
        ),
      ],
    );
  }

  Row _buildMyMsg() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text('오전 10:25'),
        SizedBox(
          width: 6,
        ),
        Container(
          child: Text('blar blar blar'),
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          constraints:
              BoxConstraints(minHeight: 40, maxWidth: size.width * 0.5),
          decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.only(
                  topLeft: roundedCorner,
                  topRight: Radius.circular(2),
                  bottomRight: roundedCorner)),
        ),
      ],
    );
  }
}
