import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytraining/db/eserciziDBworker.dart';
import 'package:mytraining/db/registriDBworker.dart';
import 'package:mytraining/db/schedeDBworker.dart';
import 'package:mytraining/db/utentiDBworker.dart';
import 'package:mytraining/models/eserciziModel.dart';
import 'package:mytraining/models/registriModel.dart';
import 'package:mytraining/models/schedeModel.dart';
import 'package:mytraining/models/utentiModel.dart';
import 'package:lottie/lottie.dart';
import 'package:mytraining/screen/login.dart';

class FirstPage2 extends StatefulWidget {
  const FirstPage2({Key? key}) : super(key: key);

  @override
  State<FirstPage2> createState() => _FirstPage2State();
}

class _FirstPage2State extends State<FirstPage2> with TickerProviderStateMixin {
  late AnimationController? _animController;
  bool isAnimFinis = false;
  bool isTextReady = false;

  @override
  void initState() {
    //Profilo2().updateVal();
    createAdminAccount();
    super.initState();
    _animController = AnimationController(vsync: this);
    _animController!.addListener(() {
      if (_animController!.value >= 1) {
        _animController!.stop();
        isAnimFinis = true;
        setState(() {});
        Future.delayed(const Duration(seconds: 1), () {
          isTextReady = true;
          setState(() {});
        });
      }
      if (isAnimFinis) {
        LoginPage().getValueLogin().then((val) async {
          if (val != null) {
            utentiModel.setStackIndex(3);
          }
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    //Profilo2().updateVal();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(seconds: 1),
            height: isAnimFinis ? screenHeight / 1.4 : screenHeight,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(40),
                bottomLeft: Radius.circular(40),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Visibility(
                  visible: !isAnimFinis,
                  child: Lottie.asset(
                    'assets/json/a.json',
                    height: screenHeight * 0.80,
                    controller: _animController,
                    onLoaded: (composition) {
                      _animController!
                        ..duration = composition.duration
                        ..forward();
                    },
                  ),
                ),
                Visibility(
                  visible: isAnimFinis,
                  child: Image.asset(
                    'assets/image/logoGym.png',
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.2,
                  ),
                ),
                Center(
                  child: AnimatedOpacity(
                      opacity: isTextReady ? 1 : 0,
                      duration: const Duration(seconds: 1),
                      child: Column(
                        children: [
                          Text(
                            'MyTraining',
                            style: GoogleFonts.adventPro(
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 60,
                                fontStyle: FontStyle.normal,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6.0),
                          Text(
                            'Schedule your training',
                            style: GoogleFonts.adventPro(
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 30,
                                fontStyle: FontStyle.normal,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ),

          // Text bottom part
          Visibility(visible: isAnimFinis, child: const _BottomPart()),
        ],
      ),
    );
  }

  void createAdminAccount() async {
    String admin = "admin";
    Utente ut = await UtentiDBworker.utentiDBworker.getId(admin);
    if (ut.id != -1) {
      return;
    }
    Utente u = Utente();
    u.nomeUtente = admin;
    u.password = admin;
    u.nome = "Mario";
    u.cognome = "Rossi";
    u.eta = "25";
    u.weight = "75";
    u.height = "185";
    await UtentiDBworker.utentiDBworker.create(u);
    ut = await UtentiDBworker.utentiDBworker.getId(admin);
    Scheda sch1 = Scheda();
    sch1.idUtente = ut.id.toString();
    sch1.nomeScheda = "Gambe e Spalle";
    sch1.durataScheda = "120";
    sch1.icona = 61562;
    int id = await SchedeDBworker.schedeDBworker.create(sch1);
    Esercizio es1_1 = Esercizio();
    es1_1.idScheda = id.toString();
    es1_1.nomeEsercizio = "Lat Machine";
    es1_1.serieEsercizio = "4";
    es1_1.ripEsercizio = "12";
    es1_1.pesoEsercizio = "40";
    es1_1.noteEsercizio = "Attento alla posizione delle mani";
    await EserciziDBworker.eserciziDBworker.create(es1_1);
    Esercizio es2_1 = Esercizio();
    es2_1.idScheda = id.toString();
    es2_1.nomeEsercizio = "Leg-Press";
    es2_1.serieEsercizio = "3";
    es2_1.ripEsercizio = "12";
    es2_1.pesoEsercizio = "80";
    es2_1.noteEsercizio = "Tenere i piedi paralleli, 1 minuto di pausa";
    await EserciziDBworker.eserciziDBworker.create(es2_1);
    Esercizio es3_1 = Esercizio();
    es3_1.idScheda = id.toString();
    es3_1.nomeEsercizio = "Curl Machine";
    es3_1.serieEsercizio = "4";
    es3_1.ripEsercizio = "10";
    es3_1.pesoEsercizio = "30";
    es3_1.noteEsercizio = "Sali veloce e scendi piano, 1.30 minuti di pausa";
    await EserciziDBworker.eserciziDBworker.create(es3_1);

    Registro reg1 = Registro();
    reg1.idScheda=id.toString();
    reg1.giorno="2022-03-12";
    reg1.durataFinale = "01:45:45.000";
    reg1.voto=(4.5).toString();
    await RegistriDBworker.registriDBworker.create(reg1);
    Registro reg2 = Registro();
    reg2.idScheda=id.toString();
    reg2.giorno="2022-03-19";
    reg2.durataFinale = "01:35:25.000";
    reg2.voto=(5).toString();
    await RegistriDBworker.registriDBworker.create(reg2);
    Registro reg3 = Registro();
    reg3.idScheda=id.toString();
    reg3.giorno="2022-03-26";
    reg3.durataFinale = "01:30:30.000";
    reg3.voto=(4).toString();
    await RegistriDBworker.registriDBworker.create(reg3);

    Scheda sch2 = Scheda();
    sch2.idUtente = ut.id.toString();
    sch2.nomeScheda = "Petto e Tricipiti";
    sch2.durataScheda = "100";
    sch2.icona = 58829;
    int id2 = await SchedeDBworker.schedeDBworker.create(sch2);
    Esercizio es1_2 = Esercizio();
    es1_2.idScheda = id2.toString();
    es1_2.nomeEsercizio = "Panca Inclinata";
    es1_2.serieEsercizio = "4";
    es1_2.ripEsercizio = "8";
    es1_2.pesoEsercizio = "45";
    es1_2.noteEsercizio = "Presa larga, 1.30 minuti di pausa";
    await EserciziDBworker.eserciziDBworker.create(es1_2);
    Esercizio es2_2 = Esercizio();
    es2_2.idScheda = id2.toString();
    es2_2.nomeEsercizio = "Chest-Press";
    es2_2.serieEsercizio = "4";
    es2_2.ripEsercizio = "8";
    es2_2.pesoEsercizio = "50";
    es2_2.noteEsercizio = "Petto in fuori";
    await EserciziDBworker.eserciziDBworker.create(es2_2);
    Esercizio es3_2 = Esercizio();
    es3_2.idScheda = id2.toString();
    es3_2.nomeEsercizio = "French Press";
    es3_2.serieEsercizio = "3";
    es3_2.ripEsercizio = "12";
    es3_2.pesoEsercizio = "20";
    es3_2.noteEsercizio = "Gomiti stretti";
    await EserciziDBworker.eserciziDBworker.create(es3_2);

    Registro reg4 = Registro();
    reg4.idScheda=id2.toString();
    reg4.giorno="2022-03-12";
    reg4.durataFinale = "01:53:53.000";
    reg4.voto=(4).toString();
    await RegistriDBworker.registriDBworker.create(reg4);
    Registro reg5 = Registro();
    reg5.idScheda=id2.toString();
    reg5.giorno="2022-03-19";
    reg5.durataFinale = "01:32:32.000";
    reg5.voto=(4.5).toString();
    await RegistriDBworker.registriDBworker.create(reg5);
    Registro reg6 = Registro();
    reg6.idScheda=id2.toString();
    reg6.giorno="2022-03-26";
    reg6.durataFinale = "01:55:41.000";
    reg6.voto=(5).toString();
    await RegistriDBworker.registriDBworker.create(reg6);

  }
}

@override
class _BottomPart extends StatelessWidget {
  const _BottomPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.1),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  margin: const EdgeInsets.only(
                    left: 50,
                    top: 20,
                    right: 50,
                  ),
                  padding: EdgeInsets.zero,
                  decoration: const BoxDecoration(),
                  child: GestureDetector(
                    onTap: () {
                      // Base.pageIndexForWidget = 1;
                      utentiModel.setStackIndex(1);
                    },
                    child: Container(
                        width: double.maxFinite,
                        height: 40,
                        padding: const EdgeInsets.only(top: 8),
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.05),
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                            ),
                            border: Border.all(color: Colors.white)),
                        child: Text(
                          '''Login''',
                          style: GoogleFonts.adventPro(
                            textStyle: const TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              fontStyle: FontStyle.normal,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          textAlign: TextAlign.center,
                        )),
                  )),
              Container(
                margin: const EdgeInsets.only(
                  left: 50,
                  top: 10,
                  right: 50,
                ),
                padding: EdgeInsets.zero,
                width: double.maxFinite,
                decoration: const BoxDecoration(),
                child: GestureDetector(
                    onTap: () {
                      utentiModel.utenteBeingEdited = Utente();
                      utentiModel.setStackIndex(2);
                    },
                    child: Container(
                        width: 10,
                        height: 40,
                        padding: const EdgeInsets.only(top: 8),
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.05),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                            ),
                            border: Border.all(color: Colors.white)),
                        child: Text(
                          '''Registrati''',
                          style: GoogleFonts.adventPro(
                            textStyle: const TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              fontStyle: FontStyle.normal,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          textAlign: TextAlign.center,
                        ))),
              ),
            ],
          ),
        ));
  }
}
