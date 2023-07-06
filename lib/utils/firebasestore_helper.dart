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

   Future<void> insertUserWhileSignIn({required Map<String,dynamic>  data}) async {
      DocumentReference  docref= await db.collection("users").add(data);

      String docId = docref.id;

      print("===============");
      print("Doc Id : ${docId}");
      print("===============");

      DocumentSnapshot<Map<String,dynamic>> docsnapShot= await db.collection("records").doc("users").get();

      var res = docsnapShot.id;

      print("===============");
      print("Doc Id : ${res}");
      print("===============");

    }


  //todo:display all user
}
