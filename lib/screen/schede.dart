import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytraining/db/eserciziDBworker.dart';
import 'package:mytraining/db/schedeDBworker.dart';
import 'package:mytraining/models/eserciziModel.dart';
import 'package:mytraining/models/schedeModel.dart';
import 'package:mytraining/models/utentiModel.dart';

class Schede extends StatelessWidget {
  final datasets = <String, dynamic>{};
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);
  Schede({Key? key}) : super(key: key) {
    eserciziModel.loadData(EserciziDBworker.eserciziDBworker);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.07),
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
                              fontSize: MediaQuery.of(context).size.height * 0.03,
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
                            //info
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
                                  border: Border.all(color: Colors.black, width: 1)),
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
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add, color: Colors.white),
          onPressed: (){
            schedeModel.schedaBeingEdited = Scheda();
            schedeModel.setStackIndex(1);
          },
        ),
        body: ListView.builder(
          itemCount: schedeModel.schedeList.length,
          itemBuilder: (BuildContext inBuildContext, int inIndex){
            Scheda scheda = schedeModel.schedeList[inIndex];
            Color color = Colors.white;

            return Card(
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              elevation: 8,
              child: Slidable(
                actionPane: const SlidableScrollActionPane(),
                actionExtentRatio: .25,
                secondaryActions: [
                  IconSlideAction(
                    caption: "Delete",
                    color: Colors.red,
                    icon: Icons.delete,
                    onTap: (){
                      //_deleteNote(context, note);
                    },
                  ),
                ],
                child: ListTile(
                  title: Text(scheda.nomeScheda),
                  subtitle: Text(scheda.durataScheda),
                  tileColor: color,
                  onLongPress: () async {
                    schedeModel.schedaBeingEdited = await SchedeDBworker.schedeDBworker.get(scheda.id);
                    schedeModel.setStackIndex(1);
                  },
                  onTap: () {
                    schedeModel.setStackIndex(2);
                  },
                ),
              ),
            );

          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color.fromARGB(255, 180, 212, 250),
          selectedItemColor: Colors.white.withOpacity(0.5),
          unselectedItemColor: colorScheme.onSurface.withOpacity(.60),
          selectedFontSize: MediaQuery.of(context).size.height * 0.02,
          unselectedFontSize: MediaQuery.of(context).size.height * 0.02,
          onTap: (value) {
            if (value == 0) {
              utentiModel.setStackIndex(3);
            } else if (value == 2) {
              utentiModel.setStackIndex(5);
            }
          },
          items: [
          BottomNavigationBarItem(
          label: 'Homepage',
          icon: const Icon(Icons.home),
        ),
      BottomNavigationBarItem(
        label: 'Schede',
        icon: const Icon(Icons.article_outlined),
      ),
      BottomNavigationBarItem(
        label: 'Profilo',
        icon: const Icon(Icons.perm_identity_sharp),
      ),
    ],
        ));
  }
}

