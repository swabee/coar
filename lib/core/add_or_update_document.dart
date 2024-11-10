import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

Future<Either<String, String>> addOrUpdateDocument(
    AddOrUpdateDocumentParams params) async {
  try {
    DocumentReference docRef;

    // Get the Firestore collection reference
    if (params.docId != null) {
      docRef = FirebaseFirestore.instance
          .collection(params.collectionName)
          .doc(params.docId);
    } else {
      docRef = await FirebaseFirestore.instance
          .collection(params.collectionName)
          .add(params.data);
      print("Document added successfully");

      return Right(docRef.id);
    }

    // If a subcollection name is provided, get the subcollection reference
    if (params.subCollectionName != null) {
      if (params.subDocId != null) {
        docRef = FirebaseFirestore.instance
            .collection(params.collectionName)
            .doc(params.docId)
            .collection(params.subCollectionName!)
            .doc(params.subDocId);
      } else {
        docRef = await FirebaseFirestore.instance
            .collection(params.collectionName)
            .doc(params.docId)
            .collection(params.subCollectionName!)
            .add(params.data);
        print("Sub-document added successfully");
        return Right(docRef.id);
      }
    }

    if (params.isUpdate) {
      await docRef.update(params.data);
      print("Document updated successfully");
      return Right(docRef.id);
    } else {
      await docRef.set(params.data);
      print("Document added successfully");
      return Right(docRef.id);
    }
  } catch (e) {
    print(params.data);
    print("Error adding/updating document: $e");
    return Left(e.toString());
  }
}

class AddOrUpdateDocumentParams {
  final String collectionName;
  final String? docId;
  final Map<String, dynamic> data;
  final String? subCollectionName;
  final String? subDocId;
  final bool isUpdate;

  AddOrUpdateDocumentParams({
    required this.collectionName,
    this.docId,
    required this.data,
    this.subCollectionName,
    this.subDocId,
    this.isUpdate = false,
  });
}
