import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../models/message.dart';
import '../widgets/chat_buble.dart';

class ChatPage extends StatelessWidget {
  static String id = 'ChatPage';
  final _controller = ScrollController();
  CollectionReference messages = FirebaseFirestore.instance.collection(kMessagesCollections);
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
   return StreamBuilder<QuerySnapshot>(
     stream: messages.orderBy(kCreatedAt,descending: true).snapshots(),
     builder: (context,snapshot){
       if(snapshot.hasData){
         List<Message> messageList = [];
         for(int i = 0; i<snapshot.data!.docs.length;i++){
           messageList.add(Message.fromJson(snapshot.data!.docs[i]));
         }
         return Scaffold(
             appBar: AppBar(
               backgroundColor: kPrimaryColor,
               automaticallyImplyLeading: false,
               title: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Image.asset(kLogo,height: 40,),
                   Text('Our chat'),
                 ],
               ),
               centerTitle: true,
             ),
             body: Column(
                 children: [
                   Expanded(
                     child: ListView.builder(
                       reverse: true,
                       controller: _controller,
                       itemCount: messageList.length,
                         itemBuilder: (context,index){
                           return ChatBuble(message: messageList[index],);
                         }),
                   ),
                   Padding(
                     padding: const EdgeInsets.all(16.0),
                     child: TextField(
                       controller: controller,
                       onSubmitted: (data){
                         messages.add({
                           kMessage:data,
                           kCreatedAt:DateTime.now(),
                          // 'id':
                         });
                         controller.clear();
                         _controller.animateTo(0, duration: Duration(seconds: 1), curve: Curves.fastLinearToSlowEaseIn);
                       },

                       decoration: InputDecoration(
                           hintText: "send message",
                           suffixIcon: Icon(
                             Icons.send,
                             color:  kPrimaryColor,
                           ),
                           border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(16)
                           ),
                           enabledBorder: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(8),
                               borderSide: BorderSide(
                                 color: kPrimaryColor,
                               )
                           )
                       ),

                     ),)
                 ]

             )
         );
       }else{
         return Text("is loading");
       }
     },
   );
  }
}



//
// class ChatPage extends StatelessWidget {
//   static String id = 'ChatPage';
//   final _controller = ScrollController();
//
//   CollectionReference messages =
//   FirebaseFirestore.instance.collection(kMessagesCollections);
//   TextEditingController controller = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: messages.snapshots(),
//         builder: (context,snapshot){
//       if(snapshot.hasData){
//        List<Message> messagesList = [];
//        for(int i = 0 ; i<snapshot.data!.docs.length; i++){
//          messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
//        }
//         return Scaffold(
//           appBar: AppBar(
//             backgroundColor: kPrimaryColor,
//             automaticallyImplyLeading: false,
//             title: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Image.asset(kLogo,height: 40,),
//                 Text('Our chat'),
//               ],
//             ),
//             centerTitle: true,
//           ),
//           body: Column(
//             children: [
//               Expanded(
//                 child: ListView.builder(
//                     itemCount: messagesList.length,
//                     itemBuilder: (context,index){
//                   return  ChatBuble(message:messagesList[index]);
//                 }),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: TextField(
//                   controller: controller,
//                   onSubmitted: (data){
//                     messages.add({
//                       'message':data,
//                       'createdAt':DateTime.now(),
//                     });
//                     controller.clear();
//                   },
//                   decoration: InputDecoration(
//                       hintText: "send message",
//                       suffixIcon: Icon(
//                         Icons.send,
//                         color:  kPrimaryColor,
//                       ),
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(16)
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide: BorderSide(
//                             color: kPrimaryColor,
//                           )
//                       )
//                   ),
//                 ),
//               )
//             ],
//           ),
//         );
//       }else{
//         return Text('loading.....');
//       }
//     });
// }
// }