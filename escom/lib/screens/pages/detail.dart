import 'dart:io';

import 'package:escom/main.dart';
import 'package:escom/screens/pages/demande.dart';
import 'package:escom/screens/pages/home.dart';
import 'package:escom/screens/pages/prestation.dart';
import 'package:escom/screens/pages/rubriques.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class SousRubriques extends StatelessWidget {
  @override
  final String documentId;

  SousRubriques({Key? key, required this.documentId}) : super(key: key);

  Widget build(BuildContext context) {
    Future<QuerySnapshot<Map<String, dynamic>>> rubriques = FirebaseFirestore
        .instance
        .collection('Rubriques')
        .doc(documentId)
        .collection("sous-rubriques")
        .get();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: Center(
        child: StreamBuilder<QuerySnapshot>(builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                                    showDialog<String>(
                                      // barrierColor: Colors.transparent,
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        //title: const Text('AlertDialog Title'),
                                        //content: const Text('AlertDialog description'),

                                        actions: <Widget>[
                                          Column(
                                            children: [
                                              SizedBox(),
                                              ElevatedButton.icon(
                                                // <-- ElevatedButton
                                                onPressed: () {
                                                  
                                                   Navigator.push(
                                                      context,
                                                      MaterialPageRoute(builder: (context) => Demande(detailId: doc.id)),
                                                    );
                                                },

                                                icon: Icon(
                                                  Icons.add_circle,
                                                  //borderRadius: BorderRadius.circular(100),
                                                  size: 24.0,
                                                  color: Colors.blue,
                                                ),
                                                label: Text(
                                                  'Download',
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.blue),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  primary: Color.fromARGB(
                                                      255, 245, 247, 248),
                                                  fixedSize:
                                                      const Size(208, 43),
                                                ),
                                              ),
                                              ElevatedButton.icon(
                                                // <-- ElevatedButton
                                                onPressed: () {
                                                   Navigator.push(
                                                      context,
                                                      MaterialPageRoute(builder: (context) => Prestation(detailId: doc.id)),
                                                    );
                                                },

                                                icon: Icon(
                                                  Icons.add_circle,
                                                  size: 24.0,
                                                  color: Colors.blue,
                                                ),
                                                label: Text(
                                                  'Download 2',
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.blue),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  primary: Color.fromARGB(
                                                      255, 245, 247, 248),
                                                  fixedSize:
                                                      const Size(208, 43),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  },
                              child: Card(
                                clipBehavior: Clip.antiAlias,
                                child: Column(children: [
                                  ListTile(
                                    title: Text('doc.id: ${doc.id}'),
                                    subtitle:
                                        Text('category:     ${doc['nom']}'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      'Greyhound divisively hello coldly wonderfully marginally far upon excluding.',
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.6)),
                                    ),
                                  ),
                                  Image.network(doc['image']),
                                ]),
                              )))
                          .toList());
                } else if (snapshot.hasError) {
                  return Text("faux");
                }
                return CircularProgressIndicator();
              });
        }),
      ),
    );
  }
}
