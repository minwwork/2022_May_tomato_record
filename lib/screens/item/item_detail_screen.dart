import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tomato_record/constants/common_size.dart';
import 'package:tomato_record/data/item_model.dart';
import 'package:tomato_record/repo/item_service.dart';

class ItemDetailScreen extends StatefulWidget {
  final String itemKey;

  const ItemDetailScreen(this.itemKey, {Key? key}) : super(key: key);

  @override
  _ItemDetailScreenState createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  PageController _pageController = PageController();
  ScrollController _scrollController = ScrollController();
  Size? _size;
  num? _statusBarHeight;
  bool isAppbarCollapsed = false;

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_size == null || _statusBarHeight == null) return;
      if (isAppbarCollapsed) {
        if (_scrollController.offset <
            _size!.width - kToolbarHeight - _statusBarHeight!) {
          isAppbarCollapsed = false;
          setState(() {});
        }
      } else {
        if (_scrollController.offset >
            _size!.width - kToolbarHeight - _statusBarHeight!) {
          isAppbarCollapsed = true;
          setState(() {});
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ItemModel>(
      future: ItemService().getItemModel(widget.itemKey),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          ItemModel itemModel = snapshot.data!;
          return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              _size = MediaQuery.of(context).size;
              _statusBarHeight = MediaQuery.of(context).padding.top;
              return Stack(
                fit: StackFit.expand,
                children: [
                  Scaffold(
                    bottomNavigationBar: SafeArea(
                      top: false,
                      bottom: true,
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(color: Colors.grey[300]!))),
                        child: Padding(
                          padding: const EdgeInsets.all(common_sm_padding),
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.favorite_border),
                                onPressed: () {},
                              ),
                              VerticalDivider(
                                thickness: 1,
                                width: common_sm_padding * 2 + 1,
                                indent: common_sm_padding,
                                endIndent: common_sm_padding,
                              ),
                              SizedBox(
                                width: common_sm_padding,
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('4,000원', style: Theme.of(context).textTheme.bodyText1,),
                                  Text('가격제안불가', style: Theme.of(context).textTheme.bodyText2,),
                                ],
                              ),
                              Expanded(
                                child: Container(),
                              ),
                              TextButton(
                                  onPressed: () {}, child: Text('채팅으로 거래하기'))
                            ],
                          ),
                        ),
                      ),
                    ),
                    body: CustomScrollView(
                      controller: _scrollController,
                      slivers: [
                        SliverAppBar(
                          pinned: true,
                          expandedHeight: _size!.width,
                          flexibleSpace: FlexibleSpaceBar(
                            title: SizedBox(
                              child: SmoothPageIndicator(
                                  controller: _pageController, // PageController
                                  count: itemModel.itemDownloadUrls.length,
                                  effect: WormEffect(
                                      activeDotColor:
                                          Theme.of(context).primaryColor,
                                      dotColor: Theme.of(context)
                                          .colorScheme
                                          .background,
                                      radius: 2,
                                      dotHeight: 4,
                                      dotWidth: 4), // your preferred effect
                                  onDotClicked: (index) {}),
                            ),
                            centerTitle: true,
                            background: PageView.builder(
                              controller: _pageController,
                              allowImplicitScrolling: true,
                              itemBuilder: (BuildContext context, int index) {
                                return ExtendedImage.network(
                                  itemModel.itemDownloadUrls[index],
                                  fit: BoxFit.cover,
                                  scale: 0.1,
                                );
                              },
                              itemCount: itemModel.itemDownloadUrls.length,
                            ),
                          ),
                        ),
                        SliverList(
                            delegate: SliverChildListDelegate([_userSection()]))
                      ],
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    height: kToolbarHeight + _statusBarHeight!,
                    child: Container(
                      height: kToolbarHeight + _statusBarHeight!,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                            Colors.black12,
                            Colors.black12,
                            Colors.black12,
                            Colors.black12,
                            Colors.transparent
                          ])),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    height: kToolbarHeight + _statusBarHeight!,
                    child: Scaffold(
                      backgroundColor: Colors.transparent,
                      appBar: AppBar(
                        backgroundColor: isAppbarCollapsed
                            ? Colors.white
                            : Colors.transparent,
                        shadowColor: Colors.transparent,
                        foregroundColor:
                            isAppbarCollapsed ? Colors.black87 : Colors.white,
                      ),
                    ),
                  )
                ],
              );
            },
          );
        }
        return Container();
      },
    );
  }

  Widget _userSection() {
    return Padding(
      padding: const EdgeInsets.all(common_sm_padding),
      child: Row(
        children: [
          ExtendedImage.network(
            'https://picsum.photos/50',
            fit: BoxFit.cover,
            width: _size!.width / 10,
            height: _size!.width / 10,
            shape: BoxShape.circle,
          ),
          SizedBox(
            width: common_sm_padding,
          ),
          SizedBox(
            height: _size!.width / 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '무무',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Text(
                  '초월읍',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ],
            ),
          ),
          Expanded(child: Container()),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 42,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        FittedBox(
                          child: Text(
                            '37.3°C',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent),
                          ),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(1),
                          child: LinearProgressIndicator(
                            color: Colors.blueAccent,
                            value: 0.373,
                            minHeight: 3,
                            backgroundColor: Colors.grey[200],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  ImageIcon(
                    ExtendedAssetImageProvider('assets/imgs/smile.png'),
                    color: Colors.blueAccent,
                  )
                ],
              ),
              SizedBox(
                width: 6,
              ),
              Text(
                '매너온도',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(decoration: TextDecoration.underline),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
