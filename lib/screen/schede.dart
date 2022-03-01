import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytraining/db/schedeDBworker.dart';
import 'package:mytraining/models/schedeModel.dart';
import 'package:mytraining/models/utentiModel.dart';

class Schede extends StatelessWidget {
  final datasets = <String, dynamic>{};
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
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
                  onTap: () async {
                    schedeModel.schedaBeingEdited = await SchedeDBworker.schedeDBworker.get(scheda.id);
                    schedeModel.setStackIndex(1);
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
              title: Text('Homepage',
                  style: GoogleFonts.adventPro(
                      textStyle: const TextStyle(
                        fontStyle: FontStyle.normal,
                        decoration: TextDecoration.none,
                      ))),
              icon: const Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              title: Text('Schede',
                  style: GoogleFonts.adventPro(
                      textStyle: const TextStyle(
                        fontStyle: FontStyle.normal,
                        decoration: TextDecoration.none,
                      ))),
              icon: const Icon(Icons.article_outlined),
            ),
            BottomNavigationBarItem(
              title: Text('Profilo',
                  style: GoogleFonts.adventPro(
                      textStyle: const TextStyle(
                        fontStyle: FontStyle.normal,
                        decoration: TextDecoration.none,
                      ))),
              icon: const Icon(Icons.perm_identity_sharp),
            ),
          ],
        ));
  }
}

