import 'package:beamer/beamer.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:tomato_record/constants/common_size.dart';
import 'package:tomato_record/screens/input/multi_image_select.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({Key? key}) : super(key: key);

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {

  bool _suggestPriceSelected = false;

  var _divider = Divider(
    height: 1,
    thickness: 1,
    color: Colors.grey[350],
    indent: common_padding,
    endIndent: common_padding,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(onPressed:(){
          context.beamBack();
        },
            style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).appBarTheme.backgroundColor),
            child: Text(
                '뒤로',
            style: Theme.of(context).textTheme.bodyText2,
            )),
        centerTitle: true,
        title: Text('중고거래 글쓰기', style: Theme.of(context).textTheme.headline6,
        ),
        actions: [
          TextButton(onPressed:(){

          },
            style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).appBarTheme.backgroundColor),
            child: Text(
              '완료',
              style: Theme.of(context).textTheme.bodyText2,
            )),
        ],

      ),

      body: ListView(
        children: [
          MultiImageSelect(),
          _divider,
          TextFormField(
            decoration: InputDecoration(
                hintText: '글 제목',
                contentPadding:
                  EdgeInsets.symmetric(horizontal: common_padding),
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                enabledBorder : UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent))),
          ),
          _divider,
          ListTile(
            dense: true,
            title: Text('선택'),
            trailing: Icon(Icons.navigate_next),
          ),
          _divider,
          Row(
            children: [
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: common_padding),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                    hintText: '얼마에 파시겠어요?',
                    prefixIcon: ImageIcon(ExtendedAssetImageProvider('assets/imgs/won.png'),
                        color: Colors.grey[350],
                    ),
                    prefixIconConstraints: BoxConstraints(maxWidth:20),
                    contentPadding:
                    EdgeInsets.symmetric(vertical: common_sm_padding),
                          border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)),
                    enabledBorder : UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent))),),
                  )),
              TextButton.icon(
                onPressed: (){
                  setState((){
                    _suggestPriceSelected = !_suggestPriceSelected;
                  });
                },
                icon: Icon(
                  Icons.check_circle_outline,
                  color: _suggestPriceSelected?Theme.of(context).primaryColor:Colors.black54,
                ),
                label : Text('가격제안 받기',
                    style: TextStyle(
                    color: _suggestPriceSelected
                        ?Theme.of(context).primaryColor
                        :Colors.black54)),
                style: TextButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    primary: Colors.black45),
              )
            ],
          )
        ],
      ),
    );
  }
}

