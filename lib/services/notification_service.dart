// import 'package:a_box_customer_app/constant/firebse_constants.dart';
// import 'package:a_box_customer_app/models/notification/notification_model.dart';
// import 'package:a_box_customer_app/service_locator/service_locator.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';


// class NotificationService {
//   NotificationService();
//   final FirebaseFirestore _firestore = locator<FirebaseFirestore>();

//   Future<void> sendNotificationToDriver(
//       NotificationModel notification, String userID) async {
//     try {
//       final DocumentReference docRef = _firestore
//           .collection(FirebaseConstants.driverCollection)
//           .doc(userID)
//           .collection(FirebaseConstants.notificationsCollection)
//           .doc();

//       final newNotification = notification.copyWith(id: docRef.id);
//       await docRef.set(newNotification.toJson());
//     } catch (e) {
//       print('Error sending notification: $e');
//     }
//   }

//   //send notification to merchant
//   Future<void> sendNotificationToMerchant(
//       NotificationModel notification, String userID) async {
//     try {
//       final DocumentReference docRef = _firestore
//           .collection(FirebaseConstants.merchantsCollection)
//           .doc(userID)
//           .collection(FirebaseConstants.notificationsCollection)
//           .doc();

//       final newNotification = notification.copyWith(id: docRef.id);
//       await docRef.set(newNotification.toJson());
//     } catch (e) {
//       print('Error sending notification: $e');
//     }
//   }
// }
