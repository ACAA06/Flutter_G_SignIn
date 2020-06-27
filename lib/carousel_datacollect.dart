import 'package:cloud_firestore/cloud_firestore.dart';

List<String> ImageList;
DocumentSnapshot details;
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

Future<DocumentSnapshot> getCarousaldetails(String url) async{

  final QuerySnapshot result =
  await Firestore.instance.collection('carousel').where("ImageUrl",isEqualTo: url).getDocuments();
  final List<DocumentSnapshot> documents = result.documents;
  if(documents.length!=0) {
      details=documents[0];
  }
  return details;
}