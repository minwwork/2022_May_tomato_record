import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class ItemModel {
 late String itemKey;
 late String userKey;
 late List<String> itemDownloadUrls;
 late String title;
 late String category;
 late num price;
 late bool negotiable;
 late String detail;
 late String address;
 late GeoFirePoint geoFirePoint;
 late DateTime createdData;
 late DocumentReference? reference;

 ItemModel({
   required this.itemKey,
   required this.userKey,
   required this.itemDownloadUrls,
   required this.title,
   required this.category,
   required this.price,
   required this.negotiable,
   required this.detail,
   required this.address,
   required this.geoFirePoint,
   required this.createdData,
   this.reference,});

 ItemModel.fromJson(Map<String, dynamic> json, this.itemKey, this.reference) {
   userKey = json['userKey'] ?? "";
   itemDownloadUrls = json['itemDownloadUrls'] != null
       ? json['itemDownloadUrls'].cast<String>()
       : [];
   title = json['title'] ?? "";
   category = json['category'] ?? "none";
   price = json['price'] ??0;
   negotiable = json['negotiable'] ??false;
   detail = json['detail'] ?? "";
   address = json['address'] ?? "";
   geoFirePoint = GeoFirePoint((json['geoFirePoint']['geopoint']).latitude,
       (json['geoFirePoint']['geopoint']).longitude);
   createdData = json['createdDate'] == null
       ? DateTime.now().toUtc()
       : (json['createdData'] as Timestamp).toDate();
 }

 ItemModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
     : this.fromJson(snapshot.data()!, snapshot.id, snapshot.reference);

 Map<String, dynamic> toJson() {
   final map = <String, dynamic>{};
   map['userKey'] = userKey;
   map['itemDownloadUrls'] = itemDownloadUrls;
   map['title'] = title;
   map['category'] = category;
   map['price'] = price;
   map['negotiable'] = negotiable;
   map['detail'] = detail;
   map['address'] = address;
   map['geoFirePoint'] = geoFirePoint.data;
   map['createdData'] = createdData;
   return map;
 }

}
