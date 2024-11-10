import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

const ipAddress = "192.168.8.164";

Future setupLocalEmulators() async {
  try {
    FirebaseFirestore.instance.useFirestoreEmulator(ipAddress, 8080);
    await FirebaseAuth.instance.useAuthEmulator(ipAddress, 9099);
    FirebaseDatabase.instance.useDatabaseEmulator(ipAddress, 9000);
    FirebaseStorage.instance.useStorageEmulator(ipAddress, 9199);
    FirebaseFunctions.instance.useFunctionsEmulator(ipAddress, 5001);
  } catch (e) {
    // ignore: avoid_print
    print(e);
  }
}
