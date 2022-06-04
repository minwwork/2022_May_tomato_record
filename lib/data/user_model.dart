import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class UserModel{
  late String userkey;
  late String phoneNumber;
  late String address;
  late num lat;
  late num lan;
  late GeoFirePoint geoFirePoint;
  late DateTime createdDate;
  DocumentReference? reference;

}