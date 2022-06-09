import 'package:beamer/beamer.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:tomato_record/data/chatroom_model.dart';
import 'package:tomato_record/repo/chat_service.dart';
import 'package:tomato_record/screens/chat/chatroom_screen.dart';
import 'package:tomato_record/states/user_notifier.dart';
import 'package:provider/provider.dart';

class ChatListPage extends StatelessWidget {
  final String userKey;
  const ChatListPage({Key? key, required this.userKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ChatroomModel>>(
        future: ChatService().getMyChatList(userKey),
        builder: (context, snapshot) {
          Size size = MediaQuery.of(context).size;
            return Scaffold(
              body: ListView.separated(
                  itemBuilder: (context, index) {
                    ChatroomModel chatroomModel = snapshot.data![index];
                    bool iamBuyer = chatroomModel.buyerKey == userKey;

                    return ListTile(
                      onTap: () {
                        context.beamToNamed('/${chatroomModel.chatroomKey}');
                      },
                      leading: ExtendedImage.network(
                        'https://randomuser.me/api/portraits/women/11.jpg',
                        shape: BoxShape.circle,
                        fit: BoxFit.cover,
                        height: size.width / 8,
                        width: size.width / 8,
                      ),
                      trailing: ExtendedImage.network(
                        chatroomModel.itemImage,
                        shape: BoxShape.rectangle,
                        fit: BoxFit.cover,
                        height: size.width / 8,
                        width: size.width / 8,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      title: RichText(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                            text: iamBuyer
                                ? chatroomModel.sellerKey
                                : chatroomModel.buyerKey,
                            style: Theme.of(context).textTheme.subtitle1,
                            children: [
                              TextSpan(text: " "),
                              TextSpan(
                                text: '${chatroomModel.itemAddress}',
                                style: Theme.of(context).textTheme.subtitle2,
                              )
                            ]),
                      ),
                      // title: Row(children: [
                      // Expanded(
                      // child: Text(iamBuyer
                      // ? chatroomModel.sellerKey
                      //     : chatroomModel.buyerKey, style: Theme
                      //     .of(context)
                      //     .textTheme
                      //     .subtitle1, maxLines: 1,
                      // overflow: TextOverflow.ellipsis,),
                      // ),
                      // Text(chatroomModel.itemAddress,
                      // style: Theme.of(context).textTheme.subtitle2, maxLines: 1,
                      // overflow: TextOverflow.ellipsis,
                      // ),
                      // ],) ,
                      // subtitle: Text(
                      // chatroomModel.lastMsg,
                      // maxLines: 1,
                      // overflow: TextOverflow.ellipsis,
                      // style: Theme.of(context).textTheme.
                      // bodyText1
                      // ,
                      // )
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      thickness: 1,
                      height: 1,
                      color: Colors.grey[300],
                    );
                  },
                  itemCount: snapshot.hasData ? snapshot.data!.length : 0),
            );
          }
        );
  }
}
