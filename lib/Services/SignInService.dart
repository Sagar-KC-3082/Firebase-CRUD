import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication{

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    print("Google  Signin Account : $googleUser");

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    print("Google  Signin Authentication : $googleAuth");


    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    print("GoogleAuth Credential : $credential");

   var x = await (FirebaseAuth.instance.signInWithCredential(credential));
   print("FirebaseAuth : $x");

    final FirebaseAuth auth = FirebaseAuth.instance;
    final User users = await auth.currentUser;
    final uid = users.uid;
    print("User UID is : $uid");
    // Once signed in, return the UserCredential
    return x;
  }

}