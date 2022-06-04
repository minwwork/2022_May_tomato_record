import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tomato_record/utils/logger.dart';

class UserService {
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