import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Future<bool> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  if (googleSignInAccount == null) {
    return false;
  }
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );
  final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
  final AuthResult authResult = await _auth.signInWithCredential(credential);
  assert(user.email != null);
  assert(user.displayName != null);
  assert(user.photoUrl != null);
  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);
  print(user.displayName);

//  return 'signInWithGoogle succeeded: $user';
  if (user != null) {
    return true;
  } else {
    return false;
  }
}

void signOutGoogle() async {
  await googleSignIn.signOut();
  await _auth.signOut();
  print("User Sign Out");
}
