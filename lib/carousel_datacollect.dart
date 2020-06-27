import 'package:cloud_firestore/cloud_firestore.dart';

List<String> ImageList;
Future<List<String>> getCarousaldata() async
{
   ImageList=[];
  final QuerySnapshot result =
      await Firestore.instance.collection('carousel').getDocuments();
  final List < DocumentSnapshot > documents = result.documents;
  if(documents.length!=0) {
for(int i=0;i<documents.length;i++)
  {
    ImageList.add(documents[i]['ImageUrl']);
  }
  }
  return ImageList;
}

Future<List<String>> getCarousaldetails(int id) async{
  final QuerySnapshot result =
  await Firestore.instance.collection('carousel').where("Id",isEqualTo: id).getDocuments();
  final List<DocumentSnapshot> documents = result.documents;
  if(documents.length!=0) {

  }
}