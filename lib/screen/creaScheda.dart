import 'package:flutter/material.dart';
import 'package:mytraining/db/schedeDBworker.dart';
import 'package:mytraining/models/schedeModel.dart';

class CreaScheda extends StatelessWidget{

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          child: Row(
            children: [
              FlatButton(
                onPressed: (){
                  schedeModel.setStackIndex(0);
                },
                child: const Text("Cancel"),
              ),
              const Spacer(),
              FlatButton(
                onPressed: (){
                  _save(context);
                },
                child: const Text("Save"),
              ),
            ],
          )
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.title),
              title: TextFormField(
                decoration: const InputDecoration(hintText: "Nome Scheda"),
                initialValue: schedeModel.schedaBeingEdited == null ? null : schedeModel.schedaBeingEdited.nomeScheda,
                validator: (String? inValue){
                  if(inValue!.isEmpty){
                    return "Please enter a name";
                  }
                  return null;
                },
                onChanged: (String inValue){
                  schedeModel.schedaBeingEdited.nomeScheda = inValue;
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.content_paste),
              title: TextFormField(
                decoration: const InputDecoration(hintText: "Duration"),
                keyboardType: TextInputType.number,
                maxLines: 1,
                initialValue: schedeModel.schedaBeingEdited == null ? null : schedeModel.schedaBeingEdited.durataScheda,
                validator: (String? inValue){
                  if(inValue!.isEmpty){
                    return "Please enter duration";
                  }
                  return null;
                },
                onChanged: (String inValue){
                  schedeModel.schedaBeingEdited.durataScheda = inValue;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _save(BuildContext context) async {

    if(!_formKey.currentState!.validate()){
      return;
    }

    //_formKey.currentState.save();

    if(schedeModel.schedaBeingEdited.id==-1){
      await SchedeDBworker.schedeDBworker.create(schedeModel.schedaBeingEdited);
    } else {
      await SchedeDBworker.schedeDBworker.update(schedeModel.schedaBeingEdited);
    }

    schedeModel.loadData(SchedeDBworker.schedeDBworker);

    schedeModel.setStackIndex(0);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
        content: Text("Cards saved"),
      ),
    );

  }
}
