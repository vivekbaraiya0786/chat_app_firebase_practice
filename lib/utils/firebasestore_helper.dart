import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreHelper {
  FireStoreHelper._();

  static final FireStoreHelper fireStoreHelper = FireStoreHelper._();

  static final FirebaseFirestore db = FirebaseFirestore.instance;

  //todo:insert user while sign in

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
<<<<<<< HEAD

  Future<void> sendChatMessage({required String msg,required String id})async{
    await db.collection("users").doc(id).collection("chat").add({"message": msg,"timestamp": FieldValue.serverTimestamp()});
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages({required String id}){
   return  db.collection("users").doc(id).collection("chat").snapshots();
  }
=======
>>>>>>> origin/master
}
