import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //-----attributes------
  final FirebaseAuth _firebaseAuth =
      FirebaseAuth.instance; //Creates a FirebaseAuth.instance

  // final GoogleSignIn googleSignIn = GoogleSignIn();

  // currentUser getter
  User? get currentUser => _firebaseAuth.currentUser;
  String? get displayName => _firebaseAuth.currentUser?.displayName;

  // authStateChanges getter
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  //Sign's a User In
  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  //Register User
  Future<String> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    final user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    return user.user!.uid;
  }

  // Get claims of the user
  Future<Map<String, dynamic>?> getUserClaims() async {
    final idTokenResult =
        await _firebaseAuth.currentUser!.getIdTokenResult(true);
    return idTokenResult.claims;
  }

  //User Sign Out Method
  Future<void> signUserOut() async {
    await _firebaseAuth.signOut();
    // await googleSignIn.signOut();
  }

  //save new user info
  Future<void> saveUserInfo() async {}

  // Future<UserCredential> signInWithGoogle() async {
  //   final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

  //   if (googleUser != null) {
  //     final GoogleSignInAuthentication googleAuth =
  //         await googleUser.authentication;

  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );

  //     return await _firebaseAuth.signInWithCredential(credential);
  //   }

  //   throw FirebaseAuthException(
  //     code: 'ERROR_ABORTED_BY_USER',
  //     message: 'Sign in aborted by user',
  //   );
  // }

  // Future<UserCredential> signInWithApple() async {
  //   final appleCredential = await SignInWithApple.getAppleIDCredential(
  //     scopes: [
  //       AppleIDAuthorizationScopes.email,
  //       AppleIDAuthorizationScopes.fullName,
  //     ],
  //   );

  //   final oauthCredential = OAuthProvider('apple.com').credential(
  //     idToken: appleCredential.identityToken,
  //     accessToken: appleCredential.authorizationCode,
  //   );

  //   final userCredential =
  //       await FirebaseAuth.instance.signInWithCredential(oauthCredential);

  //   return userCredential;
  // }
}
