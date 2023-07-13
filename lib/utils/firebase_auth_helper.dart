import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/utils/firebasestore_helper.dart';
import 'package:firebase_app/views/screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';


class SignInResponse {
  final dynamic user;
  final String? msg;

  SignInResponse({this.user, this.msg});
}

class FirebaseAuthHelper {
  FirebaseAuthHelper._();
  static final FirebaseAuthHelper firebaseAuthHelper = FirebaseAuthHelper._();

  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static final GoogleSignIn googleSignIn = GoogleSignIn();
  static final _fireStore = FirebaseFirestore.instance;


   //todo:signOut

  Future<void> signOut() async {
    await firebaseAuth.signOut();
    await googleSignIn.signOut();
  }

  Future<SignInResponse> signInAnonymously() async {
     SignInResponse signInResponse;

    try {
      UserCredential userCredential = await firebaseAuth.signInAnonymously();
      User? user = userCredential.user;

      signInResponse = SignInResponse(user: user);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "admin-restricted-operation":
          signInResponse = SignInResponse(msg: "This service temporary down");
          break;
        default:
          signInResponse = SignInResponse(msg: e.code);
          break;
      }
    }
    return signInResponse;
  }

  Future<SignInResponse> sendPasswordResetEmail(String email) async {
    SignInResponse signInResponse;

    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);

      signInResponse = SignInResponse(user:null);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          signInResponse = SignInResponse(msg: 'Invalid email address.');
          break;
        case 'user-not-found':
          signInResponse = SignInResponse(msg: 'User not found. Please check the email address.');
          break;
        default:
          signInResponse = SignInResponse(msg: 'Error sending password reset email: ${e.code}');
          break;
      }
    } catch (e) {
      signInResponse = SignInResponse(msg: 'Error sending password reset email: $e');
    }

    return signInResponse;
  }


  Future<SignInResponse> signinWithEmailPassword(
      {required String email, required String password}) async {
    SignInResponse signInResponse;

    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      signInResponse = SignInResponse(user: user);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "admin-restricted-operation":
          signInResponse = SignInResponse(msg: "This service temporary down");
          break;
        case "wrong-password":
          signInResponse = SignInResponse(msg: "Password is wrong");
          break;
        case "user-not-found":
          signInResponse = SignInResponse(msg: "User does not exists with this email id");
          break;
        case "user-disabled":
          signInResponse = SignInResponse(msg: "User is disabled ,contact admin");
          break;
        default:
          signInResponse = SignInResponse(msg: e.code);
          break;
      }
    }
    return signInResponse;
  }



//   //day 3
  Future<SignInResponse> signupWithEmailPassword({required String email, required String password,required String fcmToken}) async {
    SignInResponse signInResponse;

    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;

      signInResponse= SignInResponse(user: user);

      Map<String,dynamic> userData = {
        "email" : user!.email,
        "uid" : user.uid,
        'fcm-token': fcmToken,
      };

      await FireStoreHelper.fireStoreHelper.insertUserWhileSignIn(data: userData);

    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "admin-restricted-operation":
          signInResponse = SignInResponse(msg:"This service temporary down" );
        case "weak-password":
          signInResponse = SignInResponse(msg: "Password must be grater than 6 char.");
        case "email-already-in-use":
          signInResponse = SignInResponse(msg: "User with this email id is already exists");
        default:
          signInResponse = SignInResponse(msg: e.code);
      }
    }
    return signInResponse;
  }



//todo:signInWithGoogle
  Future<SignInResponse> signInWithGoogle({required String fcmToken}) async {
    SignInResponse signInResponse;

    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      User? user = userCredential.user;
      signInResponse = SignInResponse(user: user);

      Map<String,dynamic> userData = {
        "email" : user!.email,
        "uid" : user.uid,
        'fcm-token': fcmToken,
      };

      await FireStoreHelper.fireStoreHelper.insertUserWhileSignIn(data: userData);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "admin-restricted-operation":
          signInResponse = SignInResponse(msg: "This service temporary down");
          break;
        default:
          signInResponse = SignInResponse(msg: e.code);
          break;
      }
    }
    return signInResponse;
  }

  // Future<void> sendPasswordResetEmail(String email) async {
  //   try {
  //     await firebaseAuth.sendPasswordResetEmail(email: email);
  //     print('Password reset email sent successfully.');
  //   } on FirebaseAuthException catch (e) {
  //     print('Error sending password reset email: ${e.code}');
  //   }
  // }

  Future<void> updateUserEmail(String newEmail) async {
    User? user = firebaseAuth.currentUser;
    if (user != null) {
      try {
        await user.updateEmail(newEmail);
        print('Email updated successfully.');
      } on FirebaseAuthException catch (e) {
        print('Error updating email: ${e.code}');
      }
    }
  }

  Future<void> updatePassword(String newPassword) async {
    User? user = firebaseAuth.currentUser;
    if (user != null) {
      try {
        await user.updatePassword(newPassword);
        print('password updated successfully.');
      } on FirebaseAuthException catch (e) {
        print('Error updating password: ${e.code}');
      }
    }
  }


  Future<SignInResponse> deletedUserAccount(String email, String password) async {
    SignInResponse signInResponse;

    try {
      User? user = firebaseAuth.currentUser;
      AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);

      await user?.reauthenticateWithCredential(credential);
      await user?.sendEmailVerification();
      await user?.reload();
      await user?.delete();
      Get.offAll(const LoginPage());
      Get.snackbar('User account deleted', "Success");
      return SignInResponse(user: null);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "no-current-user":
          signInResponse = SignInResponse(msg: "User does not exist with this email id");
          break;
        case 'wrong-password':
          signInResponse = SignInResponse(msg: 'Invalid password. Please try again.');
          break;
        default:
          signInResponse = SignInResponse(msg: e.code);
          break;
      }
      return signInResponse;
    }
  }


  Future<bool> signUpWithTwitter(String name, String email, String password) async {
    try {
      UserCredential authResult;

      if (kIsWeb) {
        TwitterAuthProvider twitterProvider = TwitterAuthProvider();
        authResult = await FirebaseAuth.instance.signInWithPopup(twitterProvider);
      } else {

        AuthCredential twitterAuthCredential = TwitterAuthProvider.credential(
          accessToken: 'fi30NREWeoAJ38boAGyOmZWwN',
          secret: 'Mu91aBKrhNkTFzSSytqDveoSCxPM1uJ63loPtLPtu2YxURomM7',
        );

        authResult = await FirebaseAuth.instance.signInWithCredential(twitterAuthCredential);
      }

      User? signedInUser = authResult.user;

      if (signedInUser != null) {
        await _fireStore.collection('users').doc(signedInUser.uid).set({
          'name': signedInUser.displayName,
          'email': signedInUser.email,
          'profilePicture': signedInUser.photoURL ?? '',
          'coverImage': '',
          'bio': '',
        });

        return true;
      }

      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }
  static Future<bool> login(String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static void logout() {
    try {
      firebaseAuth.signOut();
    } catch (e) {
      print(e);
    }
  }

  //login with verification code

  Future<void> createUserWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

      await userCredential.user?.sendEmailVerification();

      print('User account created. Verification email sent to $email');
    } on FirebaseAuthException catch (e){
      print('Error creating user: ${e.code}');
    }
  }




  deleteUser()async{
    await firebaseAuth.currentUser!.delete();
  }


}





//   //without try catch
//
//   //todo:signInAnonymously
//
//   Future<User?>signInAnonymously()async{
//     UserCredential userCredential = await firebaseAuth.signInAnonymously();
//     User? user = userCredential.user;
//     return user;
//   }

//
//   //todo:signupWithEmailPassword
// Future<User?>signupWithEmailPassword({required String email,required String password})async{
//   UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
//   User? user = userCredential.user;
//   return user;
// }
//
// //todo:signinWithEmailPassword
//
// Future<User?> signinWithEmailPassword(
//     {required String email, required String password}) async {
//   UserCredential userCredential = await firebaseAuth
//       .signInWithEmailAndPassword(email: email, password: password);
//   User? user = userCredential.user;
//   return user;
// }




// //todo:signupWithEmailPassword
//   Future<Map<String, dynamic>> signupWithEmailPassword(
//       {required String email, required String password}) async {
//     Map<String, dynamic> data = {};
//
//     try {
//       UserCredential userCredential = await firebaseAuth
//           .createUserWithEmailAndPassword(email: email, password: password);
//       User? user = userCredential.user;
//       data['user'] = user;
//     } on FirebaseAuthException catch (e) {
//       switch (e.code) {
//         case "admin-restricted-operation":
//           data["msg"] = "This service temporary down";
//         case "weak-password":
//           data["msg"] = "Password must be grater than 6 char.";
//         case "email-already-in-use":
//           data["msg"] = "User with this email id is already exists";
//         default:
//           data['msg'] = e.code;
//       }
//     }
//     return data;
//   }
//
//todo:signinWithEmailPassword




//   Future<bool> signUp(String name, String email, String password) async {
//     try {
//       UserCredential authResult = await firebaseAuth.createUserWithEmailAndPassword(
//           email: email, password: password);
//
//       User? signedInUser = authResult.user;
//
//       if (signedInUser != null) {
//         _fireStore.collection('users').doc(signedInUser.uid).set({
//           'name': name,
//           'email': email,
//           'profilePicture': '',
//           'coverImage': '',
//           'bio': ''
//         });
//         return true;
//       }
//
//       return false;
//     } catch (e) {
//       print(e);
//       return false;
//     }
//   }
//
//


//
//   // Delete the user account
//   // Future<void> deleteUserAccount() async {
//   //   User? user = FirebaseAuth.instance.currentUser;
//   //
//   //   if (user != null) {
//   //     try {
//   //       await user.delete();
//   //       print('User account deleted successfully.');
//   //     } on FirebaseAuthException catch(e) {
//   //       print('Error deleting user account: ${e.code}');
//   //     }
//   //   }
//   // }
//
//   Future<void> reauthenticateAndDeleteAccount(String email, String password) async {
//     User? user = FirebaseAuth.instance.currentUser;
//
//     if (user != null) {
//       try {
//         AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);
//         await user.reauthenticateWithCredential(credential);
//         await user.delete();
//         print('User account deleted successfully.');
//       } on FirebaseAuthException catch (e) {
//         print('Error deleting user account: ${e.code}');
//       }
//     } else {
//       print('No current user. Unable to delete account.');
//     }
//   }
//
//   // Future<void> deleteduseraccount(String email, String password) async {
//   //   try {
//   //     User? user = firebaseAuth.currentUser;
//   //     AuthCredential credential =
//   //     EmailAuthProvider.credential(email: email, password: password);
//   //
//   //     await user?.reauthenticateWithCredential(credential).then((value) {
//   //       value.user?.delete().then((res) {
//   //         Get.offAll(LoginPage());
//   //         Get.snackbar('User account deleted', "Success");
//   //       });
//   //     });
//   //   } catch (error) {
//   //     Get.snackbar(
//   //         'Error', error.toString(), snackPosition: SnackPosition.BOTTOM);
//   //   }
//   // }
//
//
//   Future<void> deleteduseraccount(String email, String password) async {
//     try {
//       User? user = firebaseAuth.currentUser;
//       AuthCredential credential =
//       EmailAuthProvider.credential(email: email, password: password);
//
//       await user?.reauthenticateWithCredential(credential).then((value) {
//         value.user?.delete().then((res) {
//           Get.offAll(LoginPage());
//           Get.snackbar('User account deleted', "Success");
//         });
//       });
//     } on FirebaseAuthException catch (e) {
//       String errorMessage = 'An error occurred while deleting the user account';
//       switch (e.code) {
//         case "no-current-user":
//           errorMessage = "User does not exists with this email id";
//           break;
//         case 'wrong-password':
//           errorMessage = 'Invalid password. Please try again.';
//           break;
//         default:
//           errorMessage = e.code;
//           break;
//       }
//       Get.snackbar(
//         'Error',
//         errorMessage,
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     }
//   }
