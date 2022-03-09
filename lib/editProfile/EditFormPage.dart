import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytraining/db/utentiDBworker.dart';
import 'package:mytraining/models/utentiModel.dart';

// This class handles the Page to edit the Name Section of the User Profile.
class EditNameFormPage extends StatefulWidget {
  const EditNameFormPage({Key? key}) : super(key: key);

  @override
  EditNameFormPageState createState() {
    return EditNameFormPageState();
  }
}

class EditNameFormPageState extends State<EditNameFormPage> {
  final _formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final firstNameController = TextEditingController();
  final secondNameController = TextEditingController();
  final ageController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    super.dispose();
  }

  void updateUserValue() {
    utentiModel.utenteBeingEdited.nomeUtente = userNameController.text;
    utentiModel.utenteBeingEdited.nome = firstNameController.text;
    utentiModel.utenteBeingEdited.cognome = secondNameController.text;
    utentiModel.utenteBeingEdited.eta = ageController.text;
    utentiModel.utenteBeingEdited.height = heightController.text;
    utentiModel.utenteBeingEdited.weight = weightController.text;
  }

  var ciao = true;

  @override
  Widget build(BuildContext context) {
    if(ciao){
      userNameController.text = utentiModel.utenteBeingEdited.nomeUtente;
      firstNameController.text = utentiModel.utenteBeingEdited.nome;
      secondNameController.text = utentiModel.utenteBeingEdited.cognome;
      ageController.text = utentiModel.utenteBeingEdited.eta;
      heightController.text = utentiModel.utenteBeingEdited.height;
      weightController.text = utentiModel.utenteBeingEdited.weight;
      ciao = false;
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        //appBar: buildAppBar(context),
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.07),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.zero,
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height * 0.07,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 180, 212, 250),
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.zero,
                      decoration: const BoxDecoration(),
                      margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.01,
                        top: MediaQuery.of(context).size.width * 0.05,
                      ),
                      child: Text('MyTraining',
                          style: GoogleFonts.adventPro(
                            textStyle: TextStyle(
                              color: const Color(0xFF000000),
                              fontWeight: FontWeight.w400,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.03,
                              fontStyle: FontStyle.normal,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          textAlign: TextAlign.left,
                          maxLines: 1),
                    ),
                    Container(
                        padding: EdgeInsets.zero,
                        decoration: const BoxDecoration(),
                        margin: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * 0.03,
                          top: MediaQuery.of(context).size.width * 0.05,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            print("Mio nome utente: " +
                                utentiModel.utenteBeingEdited.nomeUtente);
                          },
                          child: Container(
                              height: MediaQuery.of(context).size.height * 0.02,
                              width: MediaQuery.of(context).size.height * 0.02,
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                    bottomLeft: Radius.circular(5),
                                  ),
                                  border: Border.all(
                                      color: Colors.black, width: 1)),
                              child: Icon(
                                Icons.info,
                                size: MediaQuery.of(context).size.height * 0.02,
                                color: const Color(0xFF000000),
                              )),
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
            child: Form(
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
              const SizedBox(
                  width: 330,
                  child: Text(
                    "Want to change something?",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 40, 16, 0),
                  child: SizedBox(
                      height: 100,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: TextFormField(
                        // Handles Form Validation for First Name
                        validator: (String? inValue){
                          if(inValue!.isEmpty){
                            return "Please enter username";
                          }
                          return null;
                        },
                        decoration:
                            const InputDecoration(labelText: 'Username'),
                        controller: userNameController,
                      ))),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                  child: SizedBox(
                      height: 100,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your first name';
                          }
                          return null;
                        },
                        decoration:
                            const InputDecoration(labelText: 'First  Name'),
                        controller: firstNameController,
                      ))),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                  child: SizedBox(
                      height: 100,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: TextFormField(
                        // Handles Form Validation for First Name
                        /* validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your first name';
                          }
                          return null;
                        }, */
                        decoration:
                            const InputDecoration(labelText: 'Second Name'),
                        controller: secondNameController,
                      ))),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                  child: SizedBox(
                      height: 100,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        // Handles Form Validation for First Name
                        /* validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your first name';
                          }
                          return null;
                        }, */
                        decoration: const InputDecoration(labelText: 'Age'),
                        controller: ageController,
                      ))),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                  child: SizedBox(
                      height: 100,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: TextFormField (
                        keyboardType: TextInputType.number,
                        // Handles Form Validation for First Name
                        /* validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your first name';
                          }
                          return null;
                        }, */
                        decoration: const InputDecoration(labelText: 'Height'),
                        controller: heightController,
                      ))),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                  child: SizedBox(
                      height: 100,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        // Handles Form Validation for First Name
                        /* validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your first name';
                          }
                          return null;
                        }, */
                        decoration: const InputDecoration(labelText: 'Weight'),
                        controller: weightController,
                      ))),
              Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.03),
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: 330,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            // Validate returns true if the form is valid, or false otherwise.
                            if (_formKey.currentState!.validate()) {
                              updateUserValue();
                              await UtentiDBworker.utentiDBworker
                                  .update(utentiModel.utenteBeingEdited);
                              Navigator.pop(context);
                            }
                          },
                          child: const Text(
                            'Update',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      )))
            ],
          ),
        )));
  }
}
