import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../codeRepete/conatants.dart';

class Prestation extends StatefulWidget {
  final String detailId;
  Prestation({required this.detailId});

  @override
  State<Prestation> createState() => _PrestationEvoie();
}

class _PrestationEvoie extends State<Prestation> {
  final CollectionReference demande =
      FirebaseFirestore.instance.collection('Prestations');

  final _formKey = GlobalKey<FormState>();
  String sujet = "";
  String cabinet = "";
  String specialite = "";
  String description = "";
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
                decoration: textInputDecoration.copyWith(hintText: 'Cabinet'),
                validator: (val) => val!.isEmpty ? 'Champ obligatoire' : null,
                onChanged: (val) {
                  setState(() => cabinet = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Specialité'),
                validator: (val) => val!.isEmpty ? 'Champ obligatoir' : null,
                onChanged: (val) {
                  setState(() => specialite = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Description'),
                  validator: (val) =>
                      val!.length < 6 ? 'Champ obligatoir ' : null,
                  onChanged: (val) {
                    setState(() => description = val);
                  }),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      demande.add({
                        "sujet": sujet,
                        "cabinet": cabinet,
                        "specialite":specialite,
                        "description":description,
                        "sousRubrique": widget.detailId,
                      }).then((_) {
                        print("succes");
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
