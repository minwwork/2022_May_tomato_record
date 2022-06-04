import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tomato_record/constants/data_keys.dart';
import 'package:tomato_record/utils/logger.dart';

class UserService {

  static final UserService _userService = UserService.internal();
  factory UserService() => _userService;
  UserService.internal();

  Future createNewUser(Map<String, dynamic> json, String userkey) async {
    DocumentReference<Map<String, dynamic>> documentReference =
    FirebaseFirestore.instance.collection(COL_USERS).doc((userkey));

    final DocumentSnapshot documentSnapshot = await documentReference.get();

    if(documentSnapshot.exists){
      await documentReference.set(json);
    }
  }

  Future firesotreTest() async {
    FirebaseFirestore.instance.collection('TESTING_COLLECTION').add(
        {'testing':'testing value','number':123123 });
  }

  void firestoreReadTest(){
    FirebaseFirestore
        .instance
        .collection('TESTING_COLLECTION')
        .doc('09aV5DHWDD84GrFI0NK1')
        .get().then((DocumentSnapshot<Map<String, dynamic>> value) =>
        logger.d(value.data()));
  }



}