import 'dart:io';

import 'package:escom/screens/pages/detail.dart';
import 'package:escom/screens/pages/rubriques.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class Rubriques extends StatefulWidget {
  @override
  ListeRubrique createState() => ListeRubrique();
}

class ListeRubrique extends State<Rubriques> {
  Future<QuerySnapshot> rubriques =
      FirebaseFirestore.instance.collection('Rubriques').get();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          return FutureBuilder<QuerySnapshot>(
        future: rubriques,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<DocumentSnapshot> documents = snapshot.data!.docs;
            return ListView(
                children: documents
                
                    .map((doc) => GestureDetector(
                      onTap: () => {

                        debugPrint('Card tapped.'),
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SousRubriques(documentId: doc.id),
                        ),
                        )
                      },
                      
                   child: Card(
                      clipBehavior: Clip.antiAlias,
                      
                        child: Column(
                          children: [
                            ListTile(  
                            title: Text(doc['nom']),
                            //subtitle: Text('category:     ${doc['nom']}'),

                      ),
                      /*Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Greyhound divisively hello coldly wonderfully marginally far upon excluding.',
                          style: TextStyle(color: Colors.black.withOpacity(0.6)),
                        ),

                      ),*/
                     
                       
              
                      Image.network(doc['image']),
                      ]),
                                   
                   )
                    )
                   )
                .toList()
                
                );
                
      } 
      else if (snapshot.hasError) {
        return Text("faux");
      }
      return CircularProgressIndicator();
    }
    );

        });
  }
}


