import 'package:beamer/beamer.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tomato_record/constants/common_size.dart';
import 'package:tomato_record/data/item_model.dart';
import 'package:tomato_record/repo/item_service.dart';
import 'package:tomato_record/repo/user_service.dart';
import 'package:tomato_record/router/locations.dart';
import 'package:tomato_record/widgets/item_list_widget.dart';

class ItemsPage extends StatefulWidget {
  final String userKey;
  const ItemsPage({Key? key, required this.userKey}) : super(key: key);

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  final List<ItemModel> _items = [];

  bool init = false;

  @override
  void initState() {
    if(!init) {
      _onRefresh();
      super.initState();
      init = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, contraints) {
        Size size = MediaQuery.of(context).size;
        final imgSize = size.width / 4;

        return AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: (_items.isNotEmpty)
                ? _listView(imgSize)
                : _shimmerListView(imgSize));
        // return _listView(imgSize);
      },
    );
  }

  Future _onRefresh() async {
    _items.clear();
    _items.addAll(await ItemService().getItems());
    setState(() {});
  }

  Widget _listView(double imgSize) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.separated(
        padding: EdgeInsets.all(common_padding),
        separatorBuilder: (context, index) {
          return Divider(
            height: common_padding * 2 + 1,
            thickness: 1,
            color: Colors.grey[200],
            indent: common_sm_padding,
            endIndent: common_sm_padding,
          );
        },
        itemBuilder: (context, index) {
          ItemModel item = _items[index];
          return ItemListWidget(item, imgSize:imgSize);
        },
        itemCount: _items.length,
      ),
    );
  }

  Widget _shimmerListView(double imgSize) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        enabled: true,
        child: ListView.separated(
          padding: EdgeInsets.all(common_padding),
          separatorBuilder: (context, index) {
            return Divider(
              height: common_padding * 2 + 1,
              thickness: 1,
              color: Colors.grey[200],
              indent: common_sm_padding,
              endIndent: common_sm_padding,
            );
          },
          itemBuilder: (context, index) {
            return SizedBox(
              height: imgSize,
              child: Row(
                children: [
                  Container(
                      height: imgSize,
                      width: imgSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      )),
                  SizedBox(
                    width: common_padding,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          height: 14,
                          width: 150,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(3),
                          )),
                      SizedBox(
                        height: 4,
                      ),
                      Container(
                          height: 12,
                          width: 180,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(3),
                          )),
                      SizedBox(
                        height: 4,
                      ),
                      Container(
                          height: 14,
                          width: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(3),
                          )),
                      Expanded(
                        child: Container(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                              height: 14,
                              width: 80,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(3),
                              )),
                        ],
                      )
                    ],
                  ))
                ],
              ),
            );
          },
          itemCount: 10,
        ));
  }
}
