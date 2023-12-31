import 'package:cloud_firestore/cloud_firestore.dart';

import 'fcm_helper.dart';

class FireStoreHelper {
  FireStoreHelper._();

  static final FireStoreHelper fireStoreHelper = FireStoreHelper._();

  static final FirebaseFirestore db = FirebaseFirestore.instance;

  //todo:insert user while sign in*

  // Future<void> insertUserWhileSignIn({required Map<String,dynamic>  data}) async {
  //   DocumentReference  docref= await db.collection("users").add(data);
  //
  //   String docId = docref.id;
  //
  //   print("===============");
  //   print("Doc Id : ${docId}");
  //   print("===============");
  // }

  // enter this data unique with show email and id
  //  Future<void> insertUserWhileSignIn({required Map<String,dynamic>  data}) async {
  //     DocumentReference  docref= await db.collection("users").add(data);
  //
  //     String docId = docref.id;
  //
  //     print("===============");
  //     print("Doc Id : ${docId}");
  //     print("===============");
  //
  //     DocumentSnapshot<Map<String,dynamic>> docsnapShot= await db.collection("records").doc("users").get();
  //
  //     var res = docsnapShot.id;
  //
  //     print("===============");
  //     print("Doc Id : ${res}");
  //     print("===============");
  //
  //   }

  Future<void> insertUserWhileSignIn(
      {required Map<String, dynamic> data}) async {
    DocumentSnapshot<Map<String, dynamic>> docSnapshot =
    await db.collection("records").doc("users").get();

    Map<String, dynamic> res = docSnapshot.data() as Map<String, dynamic>;

    print("==============");
    int id = res['id'];
    int length = res['length'];

    print(id);
    print(length);
    print("==============");

    await db.collection("users").doc("${++id}").set(data);

    await db
        .collection("records")
        .doc("users")
        .update({"id": id, "length": ++length});
  }

  //todo:display all user
  displayAllUser() {
    Stream<QuerySnapshot<Map<String, dynamic>>> userStream =
    db.collection("users").snapshots();

    return userStream;
  }

  Future<void> sendChatMessage({required String msg,required String id})async{
    await db.collection("users").doc(id).collection("chat").add({"message": msg,"timestamp": FieldValue.serverTimestamp()});
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages({required String id}){
   return  db.collection("users").doc(id).collection("chat").orderBy("timestamp",descending: true).snapshots();
  }

  Future<void> deleteUser({required String id})async{
    await db.collection("users").doc(id).delete();
  }

  Future<void> updateUser({required String id,required String email})async{
    await db.collection("users").doc(id).update({"email": email});
  }

  Future<void> fcmToken({required String id}) async {

    FCMHelper.fcmHelper.fetchFCMToken();

    await db
        .collection('users')
        .doc(id)
        .set({'fcmToken': FCMHelper.fcmHelper.fetchFCMToken(), 'createdAt': DateTime.now()});
  }


  Future<void> saveFCMTokenToFirestore(String id) async {
    String? fcmToken = await FCMHelper.fcmHelper.fetchFCMToken();
    await db.collection('users').doc(id).update({
      'fcmToken': fcmToken,
    });
  }

  Future<String?> getFCMTokenFromFirestore(String id) async {
    DocumentSnapshot snapshot =
    await db.collection('users').doc(id).get();
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      return data['fcmToken'];
    } else {
      return null;
    }
  }

}
