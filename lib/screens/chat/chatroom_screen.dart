import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:tomato_record/screens/chat/chat.dart';

class ChatroomScreen extends StatefulWidget {
  final String chatroomKey;

  const ChatroomScreen({Key? key, required this.chatroomKey}) : super(key: key);

  @override
  State<ChatroomScreen> createState() => _ChatroomScreenState();
}

class _ChatroomScreenState extends State<ChatroomScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        Size _size = MediaQuery.of(context).size;
        return Scaffold(
          appBar: AppBar(),
          backgroundColor: Colors.grey[200],
          body: SafeArea(
            child: Column(
              children: [
                MaterialBanner(
                  padding: EdgeInsets.zero,
                  leadingPadding: EdgeInsets.zero,
                  actions: [Container()],
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        dense: true,
                        leading: Padding(
                          padding: const EdgeInsets.only(
                              left: 12.0, top: 8, bottom: 4),
                          child: ExtendedImage.network(
                            'https://picsum.photos/50',
                            fit: BoxFit.cover,
                          ),
                        ),
                        contentPadding: EdgeInsets.only(left: 4, right: 0),
                        title: RichText(
                          text: TextSpan(
                              text: '거래완료',
                              style: Theme.of(context).textTheme.bodyText1,
                              children: [
                                TextSpan(
                                    text: ' 이케아 소르테라 분리수거함 5개',
                                    style:
                                        Theme.of(context).textTheme.bodyText2)
                              ]),
                        ),
                        subtitle: RichText(
                          text: TextSpan(
                              text: '30,000원',
                              style: Theme.of(context).textTheme.bodyText1,
                              children: [
                                TextSpan(
                                    text: ' (가격제안불가)',
                                    style:
                                        Theme.of(context).textTheme.bodyText2!
                                          ..copyWith(color: Colors.black12))
                              ]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                          bottom: 12,
                        ),
                        child: SizedBox(
                          height: 32,
                          child: TextButton.icon(
                            onPressed: () {},
                            icon: Icon(
                              Icons.edit,
                              size: 16,
                              color: Colors.black87,
                            ),
                            label: Text('후기 남기기',
                                style: Theme.of(context).textTheme.bodyText1!
                                  ..copyWith(color: Colors.black87)),
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    side: BorderSide(
                                        color: Colors.grey[300]!, width: 1))),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      )
                    ],
                  ),
                ),
                Expanded(
                    child: Container(
                  color: Colors.white,
                  child: ListView.separated(
                      padding: EdgeInsets.all(16),
                      itemBuilder: (context, index) {
                        bool isMine = (index % 2) == 0;
                        return Chat(
                          size: _size,
                          isMine: isMine,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 12);
                      },
                      itemCount: 30),
                )),
                _buildInputBar()
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInputBar() {
    return SizedBox(
      height: 48,
      child: Row(
        children: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.add,
                color: Colors.grey,
              )),
          Expanded(
              child: TextFormField(
            decoration: InputDecoration(
                hintText: '메세지를 입력하세요.',
                isDense: true,
                fillColor: Colors.white,
                filled: true,
                suffixIcon: GestureDetector(
                    onTap: () {
                      print('icon clicked');
                    },
                    child: Icon(
                      Icons.emoji_emotions_outlined,
                      color: Colors.grey,
                    )),
                suffixIconConstraints: BoxConstraints.tight(Size(40, 40)),
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey))),
          )),
          IconButton(
              onPressed: () {}, icon: Icon(Icons.send, color: Colors.grey))
        ],
      ),
    );
  }
}
