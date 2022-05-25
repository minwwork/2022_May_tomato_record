import 'package:beamer/beamer.dart';
import 'package:flutter/widgets.dart';
import 'package:tomato_record/screens/home_screen.dart';

class HomeLocation extends BeamLocation {
  @override
  List<BeamPage> buildPages(BuildContext context, RouteInformationSerializable state) {
    return [BeamPage(child: HomeScreen(), key: ValueKey('home'))];
  }

  @override
  List<Pattern> get pathPatterns => ['/'];

}