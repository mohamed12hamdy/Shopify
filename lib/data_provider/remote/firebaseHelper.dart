import 'package:firebase_auth/firebase_auth.dart';

class FireBaseHelper {
  FirebaseAuth auth = FirebaseAuth.instance;
  Future<dynamic> SignUp(String email, String password, String name) async {
    try {
      UserCredential User = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await auth.currentUser!.updateDisplayName(name);
      await auth.currentUser!.reload();
      if (User.user != null) {
        return User.user;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        return "email is already used";
      } else if (e.code == "weak-password") {
        return "password is top week";
      }
    }
  }

  Future<dynamic> SignIn(String email, String password) async {
    try {
      UserCredential User = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (User.user != null) {
        return User.user;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-email") {
        return "invalid mail";
      } else if (e.code == "user-not-found") {
        return "user not found";
      } else if (e.code == "wrong-password") {
        return "password is wrong";
      }
    }
  }

  Future<void> SignOut() async {
    await auth.signOut();
  }
}
