import 'package:abs_task/core/SharedPrefrence.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseLogin {
  static Future<void> login(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      await SharedPreference.init();
      await SharedPreference.saveData(key: "email", value: email);
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'Login failed';
    }
  }
}
