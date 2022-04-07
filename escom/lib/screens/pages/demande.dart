import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';

import '../../codeRepete/conatants.dart';

class Demande extends StatefulWidget {
  //const Register({ Key? key }) : super(key: key);
  final String detailId;

  Demande({required this.detailId});
  //final Function toggleView;
  //Demande({ required this.toggleView });

  @override
  // ignore: no_logic_in_create_state
  State<Demande> createState() => _DemandeEvoie();
}

class _DemandeEvoie extends State<Demande> {
  //const MyCustomForm({Key? key}) : super(key: key);
  //final AuthService _auth = AuthService();

  final CollectionReference demande =
      FirebaseFirestore.instance.collection('Demande');

  User? user = FirebaseAuth.instance.currentUser;

  final _formKey = GlobalKey<FormState>();
  String sujet = "";
  String message = "";
  String sousRubtique = "";
  String users = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Sujet'),
                validator: (val) => val!.isEmpty ? 'ENTRE UN sujet' : null,
                onChanged: (val) {
                  setState(() => sujet = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'message'),
                  validator: (val) =>
                      val!.length < 6 ? 'ENTRE UN message ' : null,
                  onChanged: (val) {
                    setState(() => message = val);
                  }),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      demande.add({
                        "sujet": sujet,
                        "message": message,
                        "sousRubrique": widget.detailId,
                        "user":user!.uid,
                      }).then((_) {
                        print("succes " + user!.uid);
                      });

                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Envoie en cour')),
                      );
                    }
                  },
                  child: const Text('Soumettre'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
