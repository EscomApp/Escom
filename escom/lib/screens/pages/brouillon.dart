import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:escom/screens/pages/detail.dart';
import 'package:escom/screens/pages/rubriques.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class Rubriquess extends StatefulWidget {
  @override
  ListeRubrique createState() => ListeRubrique();
}

class ListeRubrique extends State<Rubriquess> {
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
                                debugPrint('Navigation en cour.'),
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        SousRubriques(documentId: doc.id),
                                  ),
                                )
                              },


                          child: Card(
                            child: Container(
                              height: 250,
                              width: double.infinity,

                              decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),

                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(doc['image'])
                                  )
                                ),
                                
                                child: Row(
                                  children: <Widget>[
                                    
                                         Container(
                                            height: 50,
                                            width: MediaQuery.of(context).size.width * 0.9,
                                            color: Colors.blue
                                          ,
                                          child: Text(doc['nom']),)
                                    
                                   
                                  ],
                                  //alignment: Alignment.bottomCenter,
                                    //width: 400.0,
                                   // margin: const EdgeInsets.all(30.0),
                                    
                                   

                                    
                                    //padding: const EdgeInsets.only(bottom: 1),
                                   
                                     
                                   
                                
                                  ),

                              clipBehavior: Clip.antiAlias,
                             
                            )
                            
                          )




                          )
                          )
                      .toList()
                      );
                      
                      



            } else if (snapshot.hasError) {
              return Text("faux");
            }
            return CircularProgressIndicator();
          }
          );
    });
  }
}





/**
 *  decoration: BoxDecoration(

                                      border: Border.all(
                                        color: Colors.blueAccent,
                                        
                                        )
                                    ),
 *  child: Column(children: [
                                ListTile(
                                  title: Text('doc.id: ${doc.id}'),
                                  subtitle: Text('category:     ${doc['nom']}'),
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
 * 
 * class Demande extends StatefulWidget {
  //const Register({ Key? key }) : super(key: key);

  //final Function toggleView;
  //Demande({ required this.toggleView });

  @override
  // ignore: no_logic_in_create_state
  State<Demande> createState() => _DemandeEvoie(detailId: '');
}
 * 
 * 
 *  TextButton.icon(     // <-- TextButton
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.download,
                                            size: 24.0,
                                          ),
                                          label: Text('Download'),
                                        ),
                                        OutlinedButton.icon( // <-- OutlinedButton
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.download,
                                            size: 24.0,
                                          ),
                                          label: Text('Download'),
                                        ),
 * 
 * 
 * import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Rubriques extends StatefulWidget {
  @override
  ListeRubrique createState() => ListeRubrique();
}

class ListeRubrique extends State<Rubriques> {
  final Stream<QuerySnapshot> rubriques =
      FirebaseFirestore.instance.collection('Rubriques').snapshots();

  //ListeRubrique(this.documentId);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: rubriques,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot documents) {
              Map<String, dynamic> data = documents.data()! as Map<String, dynamic>;
              return  Material(
              child: ListTile(
                title: Text(data['nom']),
                
                subtitle: Image.network(data['image']),  //Link(data['image']).imageUrl,
              ),
              );
            }).toList(),
            
          );
        });
  }
}

 * 
 * return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot documents) {
              Map<String, dynamic> data = documents.data()! as Map<String, dynamic>;
              return  Material(
              child: ListTile(
                title: Text(data['nom']),
                
                subtitle: Image.network(data['image']),  //Link(data['image']).imageUrl,
              ),
              );
            }).toList(),
            
          );
 * 
 * 
 * import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final database1 = FirebaseFirestore.instance;
Future<QuerySnapshot> rubrique = database1
  .collection('Rubriques')
  .get();

class Rubriques extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<QuerySnapshot>(
        future: rubrique,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<QueryDocumentSnapshot<Object?>>? documents = snapshot.data!.docs;
            return ListView(
                children: documents!
                    .map((doc) => Card(
                          child: ListTile(
                        title: Text('doc.id: ${doc['nom']}'),
                        subtitle: Text('category:     ${doc['image']}'),
                      ),
                    ))
                .toList());
      } else if (snapshot.hasError) {
        print(snapshot.error);
      }
      return CircularProgressIndicator();
    }
    );
  }
}
 */

/*

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Rubriques extends StatefulWidget {
  @override
    ListeRubrique createState() => ListeRubrique();
}

class ListeRubrique extends State<Rubriques> {
  final Stream<QuerySnapshot> rubriques =
      FirebaseFirestore.instance.collection('Rubriques').snapshots();

  //ListeRubrique(this.documentId);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: rubriques,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot documents) {
              Map<String, dynamic> data =
                  documents.data()! as Map<String, dynamic>;
              return  ListTile(
                title: Text(data['nom']),
                
                subtitle: Image.network(data['image']),  //Link(data['image']).imageUrl,
              );
            }).toList(),
          );
        });
  }
}



return Card(
            child: Container(
              decoration:  BoxDecoration(
                image: DecorationImage(
                  image: new NetworkImage("https://firebasestorage.googleapis.com/v0/b/zrgx-88624.appspot.com/o/highway-gaa9701475_1920.jpg?alt=media&token=9918c7af-cfd9-4e33-bf74-7036cb8d15ed"),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter,
                ),
              ),
              child: Text("YOUR TEXT"),
            ),
          );
          
          
          
          
          
          
          
          
          return Column(
            children: snapshot.data!.docs.map((DocumentSnapshot documents) {
              Map<String, dynamic> data = documents.data()! as Map<String, dynamic>;
              return  Material(
              child: Card(
                child: Container(
                //title: Text(data['nom']),
                
                //subtitle: Image.network(data['image']),  //Link(data['image']).imageUrl,
                decoration:  BoxDecoration(
                image: DecorationImage(
                  image: new NetworkImage("https://firebasestorage.googleapis.com/v0/b/zrgx-88624.appspot.com/o/highway-gaa9701475_1920.jpg?alt=media&token=9918c7af-cfd9-4e33-bf74-7036cb8d15ed"),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter,
                ),
              ),
              ),
              )
              );
            }).toList(),
            
          );
          
          
          return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title: Text('Page title'),
        actions: [
          Icon(Icons.favorite),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.search),
          ),
          Icon(Icons.more_vert),
        ],
      ),
      body: Container(
        child:Rubriques(),
      ),
    );
    */