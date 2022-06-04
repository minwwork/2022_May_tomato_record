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

  UserModel({
    required this.userkey,
    required this.phoneNumber,
    required this.address,
    required this.lat,
    required this.lan,
    required this.geoFirePoint,
    required this.createdDate,
    required this.reference,});

  UserModel.fromJson(Map<String, dynamic> json, this.userkey, this.reference) {
    userkey = json['userkey'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    lat = json['lat'];
    lan = json['lan'];
    geoFirePoint = GeoFirePoint((json['geoFirePoint']['geopoint']).latitude, (json['geoFirePoint']['geopoint']).longitude);
    createdDate = json['createdDate'] == null
        ?DateTime.now().toUtc()
        :(json['createdData'] as Timestamp).toDate();
    reference = json['reference'];

    Map<String, dynamic> toJson() {
      final map = <String, dynamic>{};
      map['phoneNumber'] = phoneNumber;
      map['address'] = address;
      map['lat'] = lat;
      map['lan'] = lan;
      map['geoFirePoint'] = geoFirePoint.data;
      map['createdDate'] = createdDate;
      return map;
    }

  }



}