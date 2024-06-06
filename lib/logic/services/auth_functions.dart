import 'package:firebase_auth/firebase_auth.dart';

Future<String> sendOtp(String phoneNumber) async {
  String verificationId1 = "";
  await FirebaseAuth.instance.verifyPhoneNumber(
    phoneNumber: phoneNumber,
    verificationCompleted: (PhoneAuthCredential credential) {},
    verificationFailed: (FirebaseAuthException error) {},
    codeSent: (verificationId, forceResendingToken) {
      verificationId1 = verificationId;
    },
    codeAutoRetrievalTimeout: (verificationId) {},
  );
  return verificationId1;
}

signIn(String otpValue, verificationId) async {
  PhoneAuthCredential credential = PhoneAuthProvider.credential(
      smsCode: otpValue, verificationId: verificationId);
  await FirebaseAuth.instance.signInWithCredential(credential);
}
