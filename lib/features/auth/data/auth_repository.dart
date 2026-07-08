import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  AuthRepository._();

  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static User? get currentUser => _auth.currentUser;

  static Stream<User?> authStateChanges() {
    return _auth.authStateChanges();
  }

  static Future<UserCredential> login({
    required String email,
    required String password,
  }) {
    return _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  static Future<void> resetPassword({
    required String email,
  }) async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(
      email: email.trim(),
    );
  }

  static Future<UserCredential> register({
    required String email,
    required String password,
  }) {
    return _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  static Future<void> logout() {
    return _auth.signOut();
  }

  static Future<void> forgotPassword(
      String email,
      ) {
    return _auth.sendPasswordResetEmail(
      email: email,
    );
  }

  static Future<UserCredential> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn.instance;

    // Initialize once (safe to call again if needed)
    await googleSignIn.initialize();

    // Opens the Google account picker
    final GoogleSignInAccount googleUser =
    await googleSignIn.authenticate();

    // Get authentication tokens
    final googleAuth = googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    return FirebaseAuth.instance.signInWithCredential(credential);
  }
  static Future<void> createUserIfNeeded(User user) async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    if (doc.exists) return;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .set({
      "uid": user.uid,
      "name": user.displayName ?? "",
      "email": user.email ?? "",
      "photoUrl": user.photoURL ?? "",
      "username": "",
      "bio": "",
      "createdAt": FieldValue.serverTimestamp(),
      "updatedAt": FieldValue.serverTimestamp(),
    });
  }
}