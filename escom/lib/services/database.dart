import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/rubrique.dart';

class DatabaseService{
   
  final String uid;
  DatabaseService({ required this.uid });

  // collection reference
  final CollectionReference chatCollection = FirebaseFirestore.instance.collection('rubrique');

  
  //chat liste
  



// get chat  stream

}  