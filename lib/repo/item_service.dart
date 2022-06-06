import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tomato_record/constants/data_keys.dart';
import 'package:tomato_record/data/item_model.dart';

class ItemService {
  static final ItemService _itemService = ItemService.internal();

  factory ItemService() => _itemService;

  ItemService.internal();

  Future createNewItem(
      ItemModel itemModel, String itemKey, String userKey) async {
    DocumentReference<Map<String, dynamic>> itemDocReference =
        FirebaseFirestore.instance.collection(COL_ITEMS).doc(itemKey);
    DocumentReference<Map<String, dynamic>> userItemsDocReference =
        FirebaseFirestore.instance
            .collection(COL_USERS)
            .doc(userKey)
            .collection(COL_USER_ITEMS)
            .doc(itemKey);
    final DocumentSnapshot documentSnapshot = await itemDocReference.get();

    if (documentSnapshot.exists) {
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.set(itemDocReference, itemModel.toJson());
        transaction.set(userItemsDocReference, itemModel.toMinJson());
      });
    }
  }

  Future<ItemModel> getItemModel(String itemKey) async {
    DocumentReference<Map<String, dynamic>> documentReference =
        FirebaseFirestore.instance.collection(COL_ITEMS).doc(itemKey);
    final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await documentReference.get();
    ItemModel itemModel = ItemModel.fromSnapshot(documentSnapshot);
    return itemModel;
  }

  Future<List<ItemModel>> getItems() async {
    CollectionReference<Map<String, dynamic>> collectionReference =
        FirebaseFirestore.instance.collection(COL_ITEMS);
    QuerySnapshot<Map<String, dynamic>> snapshots =
        await collectionReference.get();

    List<ItemModel> items = [];

    for (int i = 0; i < snapshots.size; i++) {
      ItemModel itemModel = ItemModel.fromQuerySnapshot(snapshots.docs[i]);
      items.add(itemModel);
    }
    return items;
  }
}
