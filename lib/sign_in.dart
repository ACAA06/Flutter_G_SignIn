import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttergsignin/firstscreen.dart';
import 'package:fluttergsignin/widgets/loading.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


String name;
String email;
String imageUrl;

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Future signInWithGoogle(BuildContext context) async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
  await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final AuthResult authResult = await _auth.signInWithCredential(credential);
  final FirebaseUser user = authResult.user;

  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);

  if (user != null) {
    // Check is already sign up
    final QuerySnapshot result =
    await Firestore.instance.collection('users').where('id', isEqualTo: user.uid).getDocuments();
    final List < DocumentSnapshot > documents = result.documents;
    if(documents.length==0) {
      Navigator.push(context,MaterialPageRoute<void>(builder: (BuildContext context) =>
          getUn(user: user, EmailId: user.email)
      ));

    }else{
      name=documents[0]['username'];
      email=documents[0]['emailid'];
      imageUrl=documents[0]['photourl'];
      Navigator.push(context,MaterialPageRoute<void>(builder: (BuildContext context) =>
          FirstScreen()
      ));
    }

  }

  /*assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  assert(user.email != null);
  assert(user.displayName != null);
  assert(user.photoUrl != null);

  name = user.displayName;
  email = user.email;
  imageUrl = user.photoUrl;

  if (name.contains(" ")) {
    name = name.substring(0, name.indexOf(" "));
  }*/


  //return 'signInWithGoogle succeeded: $user';
}

void signOutGoogle() async{
  await googleSignIn.signOut();

  print("User Sign Out");
}



class getUn extends StatefulWidget {
  final FirebaseUser user;
  final String EmailId;
 getUn({@required this.user,@required this.EmailId});
  @override
  _getUnState createState() => _getUnState();
}

class _getUnState extends State<getUn> {
  @override
  String username;
BuildContext context1;
final controller=TextEditingController();
  void newuser(FirebaseUser user) async{
    name=username;
    email=user.email;
    imageUrl=user.photoUrl;
    final QuerySnapshot result =
    await Firestore.instance.collection('users').where('id', isEqualTo: user.uid).getDocuments();
    final List < DocumentSnapshot > documents = result.documents;
      // Update data to server if new user
      Firestore.instance.collection('users').document(user.uid).setData(
          { 'username': username, 'emailid': user.email,'photourl':user.photoUrl, 'id': user.uid });
    Navigator.push(context1,MaterialPageRoute<void>(builder: (BuildContext context) =>
        FirstScreen()
    ));
  }
  Widget build(BuildContext context) {
    context1=context;
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Enter Username"),
              SizedBox(height: 50),
              TextField(
                controller: controller,
              ),
              RaisedButton(
                child:Text("Continue"),
                onPressed: (){
                  username=controller.text.toString();
newuser(widget.user);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
