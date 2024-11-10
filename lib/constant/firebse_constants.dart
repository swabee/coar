import 'package:intl/intl.dart';

class FirebaseConstants {
  static const usersCollectionName = 'users';
  static const orderCollectionName = 'orders';
  static const merchantOrdersCollectionName = 'merchant-orders';
  static const ratingsCollection = "ratings";
  static const driverCollection = "drivers";
  static const merchantsCollection = "merchants";
  static const productsCollection = "products";
  static const categoryCollection = "product-categories";
  static const merchantCategoryCollection = "merchant-categories";
  static const notificationsCollection = "notifications";

  static String paymentCollectionName = 'payments';
}

final defaultTimeFormat = DateFormat('h:mm a');
final defaultDayTimeFormat = DateFormat('dd-mm-yyy h:mm a');

//date only format
final defaultDateOnlyFormat = DateFormat('dd-MM-yyyy');
