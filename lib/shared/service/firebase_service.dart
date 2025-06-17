import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  // Singleton
  static final FirebaseService instance = FirebaseService._internal();
  FirebaseService._internal();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // ----------------------- AUTH -----------------------

  User? get currentUser => _auth.currentUser;

  Future<UserCredential> signUpWithEmail({
    required String email,
    required String password,
  }) {
    return _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> signInWithEmail({
    required String email,
    required String password,
  }) {
    return _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  bool get isLoggedIn => _auth.currentUser != null;

  // -------------------- FIRESTORE --------------------

  Future<void> setDocument({
    required String collectionPath,
    required String docId,
    required Map<String, dynamic> data,
  }) {
    return _firestore.collection(collectionPath).doc(docId).set(data);
  }

  Future<void> updateDocument({
    required String collectionPath,
    required String docId,
    required Map<String, dynamic> data,
  }) {
    return _firestore.collection(collectionPath).doc(docId).update(data);
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getDocument({
    required String collectionPath,
    required String docId,
  }) {
    return _firestore.collection(collectionPath).doc(docId).get();
  }

  Future<void> deleteDocument({
    required String collectionPath,
    required String docId,
  }) {
    return _firestore.collection(collectionPath).doc(docId).delete();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamCollection({
    required String collectionPath,
  }) {
    return _firestore.collection(collectionPath).snapshots();
  }

  // ------------------ STORAGE ------------------

  Future<String> uploadFile({
    required File file,
    required String path, // Ex: 'avatars/user123.jpg'
  }) async {
    final ref = _storage.ref().child(path);
    await ref.putFile(file);
    return await ref.getDownloadURL();
  }

  Future<void> deleteFile(String path) {
    return _storage.ref().child(path).delete();
  }
}
