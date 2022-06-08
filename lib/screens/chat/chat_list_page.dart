import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class ChatListPage extends StatelessWidget {
  const ChatListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              leading: ExtendedImage.network(
                'https://randomuser.me/api/portraits/women/11.jpg',
                shape: BoxShape.circle,
                fit: BoxFit.cover,
              ),
              trailing: ExtendedImage.network(
                'https://randomuser.me/api/portraits/women/11.jpg',
                shape: BoxShape.rectangle,
                fit: BoxFit.cover,
                borderRadius: BorderRadius.circular(4),
              ),
              title: RichText(
                text: TextSpan(
                    text: 'username',
                    style: Theme.of(context).textTheme.subtitle1,
                    children: [TextSpan(text: " "), TextSpan(text: '송도1동·어제',
                      style: Theme.of(context).textTheme.subtitle2,)]),
              ),
              subtitle: Text('this is the user massage!', style: Theme.of(context).textTheme.bodyText1,),
            );
          },
          separatorBuilder: (context, index) {
            return Divider(
              thickness: 1,
              height: 1,
              color: Colors.grey[300],
            );
          },
          itemCount: 10),
    );
  }
}
