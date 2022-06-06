import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:tomato_record/constants/common_size.dart';

class SimilarItem extends StatelessWidget {
  const SimilarItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AspectRatio(
            aspectRatio: 5 / 4,
            child: ExtendedImage.network(
              'https://picsum.photos/100',
              fit: BoxFit.cover,
              borderRadius: BorderRadius.circular(8),
              shape: BoxShape.rectangle,
            )),
        Text(
          '인텍스 에어매트 듀라빔 플러스 엑스트라 베스트',
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: common_sm_padding),
          child: Text(
            '4,000원',
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
      ],
    );
  }
}
