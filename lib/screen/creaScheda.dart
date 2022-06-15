import 'package:flutter/material.dart';
import 'package:mytraining/common/appbar.dart';
import 'package:mytraining/db/schedeDBworker.dart';
import 'package:mytraining/models/schedeModel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytraining/models/utentiModel.dart';
import 'package:mytraining/screen/login.dart';
import 'package:mytraining/screen/schede.dart';


class CreaScheda extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: buildAppBar(context),
      backgroundColor: const Color.fromARGB(255, 42, 42, 42),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.width * 0.05,
              ),
            ),
            SizedBox(
                width: 330,
                child: Text(
                  "Crea la tua Scheda!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.adventPro(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 24,
                      fontStyle: FontStyle.normal,
                      decoration: TextDecoration.none,
                    ),
                  ),
                )),
            SizedBox(
                width: 330,
                child: Text(
                  "Scegli il nome della scheda, la data, la possibile \n durata ed un'icona rappresentativa.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.adventPro(
                    textStyle: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      fontStyle: FontStyle.normal,
                      decoration: TextDecoration.none,
                    ),
                  ),
                )),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: SizedBox(
                  height: 70,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: TextFormField(
                    style: GoogleFonts.adventPro(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: MediaQuery.of(context).size.width * 0.045,
                        fontStyle: FontStyle.normal,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    maxLength: 16,
                    initialValue: schedeModel.schedaBeingEdited == null
                        ? null
                        : schedeModel.schedaBeingEdited.nomeScheda,
                    validator: (String? inValue) {
                      if (inValue!.isEmpty) {
                        return "Inserisci Nome";
                      }
                      return null;
                    },
                    onChanged: (String inValue) {
                      schedeModel.schedaBeingEdited.nomeScheda = inValue;
                    },
                    decoration: const InputDecoration(
                        labelText: "Nome Scheda",
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        counterText: ""),
                  ),
                )),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: SizedBox(
                  height: 70,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: TextFormField(
                    style: GoogleFonts.adventPro(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: MediaQuery.of(context).size.width * 0.045,
                        fontStyle: FontStyle.normal,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    maxLength: 4,
                    keyboardType: TextInputType.number,
                    initialValue: schedeModel.schedaBeingEdited == null
                        ? null
                        : schedeModel.schedaBeingEdited.durataScheda,
                    validator: (String? inValue) {
                      if (inValue!.isEmpty) {
                        return "Inserisci Durata";
                      }
                      return null;
                    },
                    onChanged: (String inValue) {
                      schedeModel.schedaBeingEdited.durataScheda = inValue;
                    },
                    decoration: const InputDecoration(
                        labelText: "Durata Scheda (m)",
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        counterText: ""),
                  ),
                )),
            Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.width * 0.05,
                bottom: MediaQuery.of(context).size.width * 0.07,
              ),
              padding: EdgeInsets.zero,
              width: double.maxFinite,
              decoration: const BoxDecoration(),
              child: Text(r'''Seleziona Icona''',
                  style: GoogleFonts.adventPro(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      fontStyle: FontStyle.normal,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1),
            ),
            Container(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [


                    Container(
                        margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.08,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: schedeModel.schedaBeingEdited.icona == 61562 ? Colors.white : Colors.black.withOpacity(0),
                              width: 1.5
                          ),
                          color: Colors.white.withOpacity(0),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                            icon: const Icon(Icons.fitness_center_outlined),
                            color: Colors.white,
                            onPressed: () {
                              saveIcona(61562);
                              schedeModel.setNIcona(61562);
                            })),
                    Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: schedeModel.schedaBeingEdited.icona == 58829 ? Colors.white : Colors.black.withOpacity(0),
                              width: 1.5
                          ),
                          color: Colors.white.withOpacity(0),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                            icon: const Icon(Icons.snowboarding ),
                            color: Colors.white,
                            onPressed: () {
                              saveIcona(58829);
                              schedeModel.setNIcona(58829);
                            })),
                    Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: schedeModel.schedaBeingEdited.icona == 58862 ? Colors.white : Colors.black.withOpacity(0),
                              width: 1.5
                          ),
                          color: Colors.white.withOpacity(0),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                            icon: const Icon(Icons.sports_mma),
                            color: Colors.white,
                            onPressed: () {
                              saveIcona(58862);
                              schedeModel.setNIcona(58862);
                            })),
                    Container(
                        margin: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * 0.08,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: schedeModel.schedaBeingEdited.icona == 58861 ? Colors.white : Colors.black.withOpacity(0),
                              width: 1.5
                          ),
                          color: Colors.white.withOpacity(0),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                            icon: const Icon(Icons.sports_kabaddi ),
                            color: Colors.white,
                            onPressed: () {
                              saveIcona(58861);
                              schedeModel.setNIcona(58861);
                            })),


                  ]),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 30,
                top: 40,
                right: 30,
              ),
              padding: EdgeInsets.zero,
              width: double.maxFinite,
              decoration: const BoxDecoration(),
              child: GestureDetector(
                  onTap: () async {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      _save(context);
                    }
                  },
                  child: Container(
                      width: 10,
                      height: 50,
                      padding: const EdgeInsets.only(top: 8),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 230, 245, 252),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          ),
                          border: Border.all(color: Colors.white)),
                      child: Text(
                        'Aggiungi',
                        style: GoogleFonts.adventPro(
                          textStyle: const TextStyle(
                            color: const Color.fromARGB(255, 42, 42, 42),
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            fontStyle: FontStyle.normal,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        textAlign: TextAlign.center,
                      ))),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          child: Row(
            children: [
              FlatButton(
                onPressed: () {
                  schedeModel.setStackIndex(0);
                },
                child: Text(
                  "Indietro",
                  style: GoogleFonts.adventPro(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      fontStyle: FontStyle.normal,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  void _save(BuildContext context) async {
    print(context); //dopo vedo cosa contiene
    if (!_formKey.currentState!.validate()) {
      return;
    }

    //_formKey.currentState.save();

    if (schedeModel.schedaBeingEdited.id == -1) {
      LoginPage().getValueLogin().then((val) async {
        schedeModel.schedaBeingEdited.idUtente = val.toString();
      });
      await SchedeDBworker.schedeDBworker.create(schedeModel.schedaBeingEdited);
    } else {
      await SchedeDBworker.schedeDBworker.update(schedeModel.schedaBeingEdited);
    }
    Schede.hoCaricatoleSchede = false;
    LoginPage().getValueLogin().then((val) async {
      await schedeModel.loadData(SchedeDBworker.schedeDBworker, val);
    });
    Schede.hoCaricatoleSchede = true;
    // Base.pageIndexForWidget=4;
    schedeModel.setStackIndex(0);
    utentiModel.setStackIndex(4);
  }

  void saveIcona(int n) {
    schedeModel.schedaBeingEdited.icona = n;
  }
}
