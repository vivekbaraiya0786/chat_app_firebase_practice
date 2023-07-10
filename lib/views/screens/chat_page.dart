import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../utils/firebasestore_helper.dart';

class chat_page extends StatefulWidget {
  const chat_page({Key? key}) : super(key: key);

  @override
  State<chat_page> createState() => _chat_pageState();
}

class _chat_pageState extends State<chat_page> {

  TextEditingController messageController = TextEditingController();
  String?  msg;
  @override
  Widget build(BuildContext context) {
    QueryDocumentSnapshot<Map<String, dynamic>> userDoc =
        ModalRoute.of(context)!.settings.arguments
            as QueryDocumentSnapshot<Map<String, dynamic>>;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat Page"),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 12,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: StreamBuilder(
                stream: FireStoreHelper.fireStoreHelper.getMessages(id: userDoc.id),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("${snapshot.error}"),
                    );
                  } else if (snapshot.hasData) {
                    QuerySnapshot<Map<String, dynamic>> data  = snapshot.data as QuerySnapshot<Map<String, dynamic>>;
                    List<QueryDocumentSnapshot<Map<String, dynamic>>> allDocs =  data.docs;
                    return ListView.builder(
                      reverse: true,
                      itemCount: allDocs.length,
                      itemBuilder: (context, index) {
                        return  ListTile(
                          title: Text("${allDocs[index].data()['message']}"),
                          subtitle: Text("${allDocs[index].data()['timestamp']}"),
                        );
                      },
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ),
          Expanded(flex: 2,child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  flex: 12,
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: "Enter Your Message",
                      border: OutlineInputBorder()
                    ),
                    controller: messageController,
                    // onChanged: (value) {
                    //   setState(() {
                    //     msg = value;
                    //   });
                    // },
                  ),
                ),
                Expanded(
                    child: IconButton(
                  onPressed: () async{
                    await FireStoreHelper.fireStoreHelper.sendChatMessage(msg: messageController.text, id: userDoc.id);
                    messageController.clear();
                  },
                  icon: const Icon(Icons.send),
                ))
              ],
            ),
          ),),
        ],
      ),
    );
  }
}
