import 'package:firebase_auth/firebase_auth.dart';
import 'package:toy_trader/models/ProfileInfo.dart';

import '../../models/Toy.dart';

class AuthService{
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;


  ProfileInfo? _userFromFirebaseUser(User? user){
    return user != null ? ProfileInfo(user.uid, user.displayName!, <int>[], <String>[], <Toy>[], user.photoURL! ) : null;
  }

  Stream<ProfileInfo?> get user {
    return firebaseAuth.authStateChanges().map((User? user) => _userFromFirebaseUser(user));
  }


  Future signIn( String email, String pw) async {
    try{
      UserCredential result = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: pw);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }

  }
}
