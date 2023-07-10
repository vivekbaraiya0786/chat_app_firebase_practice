import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/utils/firebase_auth_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late File? image = null;
  final ImagePicker _imagePicker = ImagePicker();

  final GlobalKey<FormState> deleteformkey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? Email;
  String? Password;

  bool isAnonymous = false;
  bool isEmailPassword = false;

  @override
  void initState() {
    super.initState();
    checkAuthMethod();
  }

  void checkAuthMethod() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      isAnonymous = user.isAnonymous;
      isEmailPassword = user.providerData.any((userInfo) =>
      userInfo.providerId == 'password' || userInfo.providerId == 'email');
    }
  }

  void handleAdd() {
    if (isAnonymous || isEmailPassword) {
      setState(() {
        chooseImage();
      });
    } else {
      print('Add functionality not available');
    }
  }

  void handleEdit() {
    if (isAnonymous || isEmailPassword) {
      setState(() {

      });
    } else {
      print('Edit functionality not available');
    }
  }

  void  handleDelete() {
    if (isAnonymous || isEmailPassword) {
      setState(() {
        image = null;
      });
    } else {
      print('Delete functionality not available');
    }
  }

  Future<void> image_pick(ImageSource source) async {
    final pickedImage = await _imagePicker.pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    }
  }

  void chooseImage(){
    Get.dialog(
      AlertDialog(
        title: const Text('Select Image Source'),
        actions: [
          TextButton(
            onPressed: () {
              image_pick(ImageSource.camera);
              Get.back();
            },
            child: const Text('Camera'),
          ),
          TextButton(
            onPressed: () {
              image_pick(ImageSource.gallery);
              Get.back();
            },
            child: const Text('Gallery'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    User? user = ModalRoute.of(context)!.settings.arguments as User?;

    return Scaffold(
        drawer: Drawer(
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.08,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    chooseImage();
                  });
                },
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: image != null
                          ? FileImage(image!)
                          : (user?.photoURL != null
                          ? NetworkImage(user!.photoURL!) as ImageProvider
                          : const AssetImage('assets/images/1.jpeg')),
                    ),
                    if (isAnonymous || isEmailPassword)
                      GestureDetector(
                        onTap: handleAdd,
                        child: const CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 16,
                          child: Icon(Icons.add, color: Colors.black),
                        ),
                      ),
                  ],
                ),
              ),
              const Divider(
                color: Colors.black,
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              (user!.isAnonymous)
                  ? const Text("")
                  : (user.displayName == null)
                  ? const Text("")
                  : Text("UserName : ${user.displayName}"),
              SizedBox(
                height: Get.height * 0.02,
              ),
              (user.isAnonymous) ? const Text("") : Text("Email : ${user.email}"),
              SizedBox(
                height: Get.height * 0.02,
              ),
              ListTile(
                onTap: () {
                  Get.toNamed("/update_Email");
                },
                title: const Text("Update your Email"),
                trailing: const Icon(Icons.email_outlined),
              ),
              ListTile(
                onTap: () {
                  Get.toNamed("/update_Password");
                },
                title: const Text("Update your password"),
                trailing: const Icon(Icons.password_outlined),
              ),
              ListTile(
                onTap: () {
                  Get.toNamed("/deleteAccount");
                },
                title: const Text('Delete your Account'),
                trailing: const Icon(Icons.delete),
              ),
              if (isAnonymous || isEmailPassword)
                ListTile(
                  onTap: handleEdit,
                  leading: const Icon(Icons.edit),
                  title: const Text('Edit'),
                ),
              if (isAnonymous || isEmailPassword)
                ListTile(
                  onTap: handleDelete,
                  leading: const Icon(Icons.delete),
                  title: const Text('Delete'),
                ),
            ],
          ),
        ),
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                signOut();
              },
              icon: const Icon(CupertinoIcons.power),
            ),
          ],
        ),
        body: StreamBuilder(
          // stream: FireStoreHelper.fireStoreHelper.displayAllUser(),
          stream: FirebaseFirestore.instance.collection("users").snapshots(),
          builder: (context, snapshot) {

            if(snapshot.hasError){
              return Center(child: Text("${snapshot.error}"),);
            }else if(snapshot.hasData){

              QuerySnapshot<Map<String, dynamic>> data  = snapshot.data as QuerySnapshot<Map<String, dynamic>>;
<<<<<<< HEAD
              List<QueryDocumentSnapshot<Map<String, dynamic>>> allDocs =  data.docs;

              return ListView.builder(itemCount: allDocs.length,itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed("/chat_page",arguments: allDocs[index]);
                  },
                  leading: Text("${index +1}"),
                  title:Text("${allDocs[index].data()['email']}") ,
                  subtitle: Text("${allDocs[index].data()['uid']}"),
=======
              List<QueryDocumentSnapshot<Map<String, dynamic>>> alldocs =  data.docs;

              return ListView.builder(itemCount: alldocs.length,itemBuilder: (context, index) {
                return ListTile(
                  leading: Text("${index +1}"),
                  title:Text("${alldocs[index].data()['email']}") ,
                  subtitle: Text("${alldocs[index].data()['uid']}"),
>>>>>>> origin/master
                );
              },);

            }

            return Center(child: CircularProgressIndicator(),);
          },
        )
    );
  }

  Future<void> signOut() async {
    await FirebaseAuthHelper.firebaseAuthHelper.signOut();
    Get.offAllNamed("/");
    Get.snackbar(
      "Signed Out",
      "You have been successfully signed out",
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}

// GestureDetector(
//   onTap: () {
//     Get.dialog(
//       AlertDialog(
//         title: const Text('Select Image Source'),
//         actions: [
//           TextButton(
//             onPressed: () {
//               image_pick(ImageSource.camera);
//               Get.back();
//             },
//             child: const Text('Camera'),
//           ),
//           TextButton(
//             onPressed: () {
//               image_pick(ImageSource.gallery);
//               Get.back();
//             },
//             child: const Text('Gallery'),
//           ),
//         ],
//       ),
//     );
//   },
//   child: CircleAvatar(
//     radius: 60,
//     backgroundImage: image != null
//         ? FileImage(image!)
//         : NetworkImage("${user!.photoURL}") as ImageProvider,
//   ),
// ),

// Get.dialog(
//   AlertDialog(
//     title: const Text('Delete Account'),
//     content: Form(
//       key: deleteformkey,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           TextFormField(
//             controller: emailController,
//             decoration: const InputDecoration(labelText: 'Email'),
//             onSaved: (newValue) {
//               Email = newValue;
//             },
//             validator: (value) {
//               if (value!.isEmpty) {
//                 return 'Please enter your email';
//               }
//               return null;
//             },
//           ),
//           TextFormField(
//             controller: passwordController,
//             onSaved: (newValue) {
//               Password = newValue;
//             },
//             decoration: const InputDecoration(labelText: 'Password'),
//             obscureText: true,
//             validator: (value) {
//               if (value!.isEmpty) {
//                 return 'Please enter your password';
//               }
//               return null;
//             },
//           ),
//         ],
//       ),
//     ),
//     actions: [
//       TextButton(
//         onPressed: () {
//           Get.back(); // Close the dialog
//         },
//         child: const Text('Cancel'),
//       ),
//       TextButton(
//         onPressed: () {
//           if (deleteformkey.currentState!.validate()) {
//             deleteformkey.currentState!.save();
//
//             FirebaseAuthHelper.firebaseAuthHelper.reauthenticateAndDeleteAccount(Email!, Password!);
//             Get.offAllNamed("/");
//             Get.snackbar(
//               "successfully delete",
//               "You have been successfully delete your account",
//               snackPosition: SnackPosition.BOTTOM,
//             );
//           }
//         },
//         child: const Text('Delete'),
//       ),
//     ],
//   ),
// );
