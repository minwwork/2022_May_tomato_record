import 'package:beamer/beamer.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:tomato_record/constants/common_size.dart';
import 'package:tomato_record/screens/input/multi_image_select.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({Key? key}) : super(key: key);

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {

  bool _suggestPriceSelected = false;

  TextEditingController _priceController = TextEditingController();

  var _border = UnderlineInputBorder(
      borderSide : BorderSide(color: Colors.transparent));

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
                border: _border,
                focusedBorder: _border,
                enabledBorder : _border),
          ),
          _divider,
          ListTile(
            onTap: (){
              context.beamToNamed('/input/category_input');
            },
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
                      controller:  _priceController,
                      onChanged: (value){
                        if(value == '0원') {
                          _priceController.clear();
                        }
                        setState((){
                        });
                      },
                      inputFormatters: [
                        MoneyInputFormatter(
                            mantissaLength: 0, trailingSymbol: '원')
                      ],
                      decoration: InputDecoration(
                    hintText: '얼마에 파시겠어요?',
                    prefixIcon: ImageIcon(ExtendedAssetImageProvider('assets/imgs/won.png'),
                        color: (_priceController.text.isEmpty)
                            ?Colors.grey[350]
                            :Colors.black87,
                    ),
                    prefixIconConstraints: BoxConstraints(maxWidth:20),
                    contentPadding:
                    EdgeInsets.symmetric(vertical: common_sm_padding),
                          border: _border,
                    focusedBorder: _border,
                    enabledBorder : _border),),
                  )),
              TextButton.icon(
                onPressed: (){
                  setState((){
                    _suggestPriceSelected = !_suggestPriceSelected;
                  });
                },
                icon: Icon(
                  _suggestPriceSelected
                    ?Icons.check_circle
                    :Icons.check_circle_outline,
                  color: _suggestPriceSelected
                      ?Theme.of(context).primaryColor
                      :Colors.black54,
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
          ),
          _divider,
          TextFormField(
            maxLines: null,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
                hintText: '당신 근처에 올릴 게시글 내용을 작성해주세요.\n가품 및 판매금지 품목은 게시가 제한될 수 있어요.',
                contentPadding:
                EdgeInsets.symmetric(horizontal: common_padding),
                border: _border,
                focusedBorder: _border,
                enabledBorder : _border),
          ),
        ],
      ),
    );
  }
}

