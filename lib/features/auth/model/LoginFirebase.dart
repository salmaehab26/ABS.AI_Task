import 'package:firebase_auth/firebase_auth.dart';

class FirebaseLogin {
  static Future<void> login(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'Login failed';
    }
  }
}
