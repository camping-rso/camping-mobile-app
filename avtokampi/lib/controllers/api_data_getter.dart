import 'dart:convert';

import 'package:avtokampi/globals.dart' as globals;
import 'package:avtokampi/models/Avtokamp.dart';
import 'package:avtokampi/models/Cenik.dart';
import 'package:avtokampi/models/Drzava.dart';
import 'package:avtokampi/models/KampirnoMesto.dart';
import 'package:avtokampi/models/Kategorija.dart';
import 'package:avtokampi/models/Mnenje.dart';
import 'package:avtokampi/models/Regija.dart';
import 'package:avtokampi/models/Rezervacija.dart';
import 'package:avtokampi/models/Slika.dart';
import 'package:avtokampi/models/StatusRezervacije.dart';
import 'package:avtokampi/models/VrstaKampiranja.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'api_controller.dart';

class ApiDataGetter {
    ApiController apiController = new ApiController();

    getAvtokampi() {
        Response response;
        apiController.getAvtokampi().then((apiResponse) {
            response = apiResponse;
        }).whenComplete(() {
            if (response.statusCode == 200) {
                Iterable l = json.decode(response.body);
                globals.avtokampi =
                    l.map((model) => Avtokamp.fromJson(model)).toList();
            }
            print("Avtokampi: ${globals.avtokampi.toString()}");
            getCeniki();
            getMnenja();
            getSlike();
            getKampirnaMesta();
        });
    }

    getCeniki() {
        for (Avtokamp avtokamp in globals.avtokampi) {
            Response response;
            apiController.getCenikiForKamp(avtokamp.id).then((apiResponse) {
                response = apiResponse;
            }).whenComplete(() {
                if (response.statusCode == 200) {
                    Iterable l = json.decode(response.body);
                    List<Cenik> cenikiZaKamp = l.map((model) =>
                        Cenik.fromJson(model)).toList();
                    for (Cenik c in cenikiZaKamp) {
                        if (!globals.ceniki.contains(c)) {
                            globals.ceniki.add(c);
                        }
                    }
                }
                print("Ceniki: ${globals.ceniki.toString()}");
            });
        }
    }

    getDrzave() {
        Response response;
        apiController.getDrzave().then((apiResponse) {
            response = apiResponse;
        }).whenComplete(() {
            if (response.statusCode == 200) {
                Iterable l = json.decode(response.body);
                globals.drzave =
                    l.map((model) => Drzava.fromJson(model)).toList();
            }
            print("Drzave: ${globals.drzave.toString()}");
        });
    }

    getKampirnaMesta() {
        for (Avtokamp avtokamp in globals.avtokampi) {
            Response response;
            apiController.getKampirnaMestaForKamp(avtokamp.id).then((
                apiResponse) {
                response = apiResponse;
            }).whenComplete(() {
                if (response.statusCode == 200) {
                    Iterable l = json.decode(response.body);
                    List<KampirnoMesto> kampirnaMestaZaKamp = l.map((model) =>
                        KampirnoMesto.fromJson(model)).toList();
                    for (KampirnoMesto km in kampirnaMestaZaKamp) {
                        if (!globals.kampirnaMesta.contains(km)) {
                            globals.kampirnaMesta.add(km);
                        }
                    }
                }
                print("Kampirna mesta: ${globals.kampirnaMesta.toString()}");
            });
        }
    }

    getKategorije() {
        Response response;
        apiController.getKategorije().then((apiResponse) {
            response = apiResponse;
        }).whenComplete(() {
            if (response.statusCode == 200) {
                Iterable l = json.decode(response.body);
                globals.kategorije =
                    l.map((model) => Kategorija.fromJson(model)).toList();
            }
            print("Kategorije: ${globals.kategorije.toString()}");
        });
    }

    getMnenja() {
        for (Avtokamp avtokamp in globals.avtokampi) {
            Response response;
            apiController.getMnenjaForKamp(avtokamp.id).then((apiResponse) {
                response = apiResponse;
            }).whenComplete(() {
                if (response.statusCode == 200) {
                    Iterable l = json.decode(response.body);
                    List<Mnenje> mnenjaZaKamp = l.map((model) =>
                        Mnenje.fromJson(model)).toList();
                    for (Mnenje km in mnenjaZaKamp) {
                        if (!globals.mnenja.contains(km)) {
                            globals.mnenja.add(km);
                        }
                    }
                }
                print("Mnenja: ${globals.mnenja.toString()}");
            });
        }
    }

    getRegije() {
        Response response;
        apiController.getRegije().then((apiResponse) {
            response = apiResponse;
        }).whenComplete(() {
            if (response.statusCode == 200) {
                Iterable l = json.decode(response.body);
                globals.regije =
                    l.map((model) => Regija.fromJson(model)).toList();
            }
            print("Regije: ${globals.regije.toString()}");
        });
    }

    getRezervacije() {
        Response response;
        apiController.getRezervacijeForUser().then((apiResponse) {
            response = apiResponse;
        }).whenComplete(() {
            if (response.statusCode == 200) {
                Iterable l = json.decode(response.body);
                globals.rezervacije =
                    l.map((model) => Rezervacija.fromJson(model)).toList();
            }
            print("Rezervacije: ${globals.rezervacije.toString()}");
        });
    }

    getSlike() {
        for (Avtokamp avtokamp in globals.avtokampi) {
            Response response;
            apiController.getSlikeForKamp(avtokamp.id).then((apiResponse) {
                response = apiResponse;
            }).whenComplete(() {
                if (response.statusCode == 200) {
                    Iterable l = json.decode(response.body);
                    List<Slika> slikeZaKamp = l.map((model) =>
                        Slika.fromJson(model)).toList();
                    for (Slika km in slikeZaKamp) {
                        if (!globals.slike.contains(km)) {
                            globals.slike.add(km);
                        }
                    }
                }
                print("Slike: ${globals.slike.toString()}");
            });
        }
    }

    getStatusiRezervacij() {
        Response response;
        apiController.getRegije().then((apiResponse) {
            response = apiResponse;
        }).whenComplete(() {
            if (response.statusCode == 200) {
                Iterable l = json.decode(response.body);
                globals.statusiRezervacij = l
                    .map((model) => StatusRezervacije.fromJson(model))
                    .toList();
            }
            print(
                "Statusi rezervacij: ${globals.statusiRezervacij.toString()}");
        });
    }

    getVrsteKampiranj() {
        Response response;
        apiController.getVrsteKampiranj().then((apiResponse) {
            response = apiResponse;
        }).whenComplete(() {
            if (response.statusCode == 200) {
                Iterable l = json.decode(response.body);
                globals.vrsteKampiranj =
                    l.map((model) => VrstaKampiranja.fromJson(model)).toList();
            }
            print("Vrste kampiranj: ${globals.vrsteKampiranj.toString()}");
        });
    }

    getPodatkiZaUporabnika() {
        print("Uporabnik: ${globals.currentUser.toString()}");
        getRezervacije();
    }

    setGlobals() async {
        if (!globals.dataLoaded) {
            await getPodatkiZaUporabnika();
            await getAvtokampi();
            await getDrzave();
            await getKategorije();
            await getRegije();
            await getStatusiRezervacij();
            await getVrsteKampiranj();
            globals.dataLoaded = true;
            print("KONČNI PODATKI:");
            print("Uporabnik: ${globals.currentUser.toString()}");
            print("Avtokampi: ${globals.avtokampi.toString()}");
            print("Ceniki: ${globals.ceniki.toString()}");
            print("Drzave: ${globals.drzave.toString()}");
            print("Kampirna mesta: ${globals.kampirnaMesta.toString()}");
            print("Kategorije: ${globals.kategorije.toString()}");
            print("Mnenja: ${globals.mnenja.toString()}");
            print("Regije: ${globals.regije.toString()}");
            print("Rezervacije: ${globals.rezervacije.toString()}");
            print("Slike: ${globals.slike.toString()}");
            print(
                "Statusi rezervacij: ${globals.statusiRezervacij.toString()}");
            print("Vrste kampiranj: ${globals.vrsteKampiranj.toString()}");
        }
    }

    static loadData(context) {
        ProgressDialog pr = new ProgressDialog(
            context, type: ProgressDialogType.Normal,
            isDismissible: false,
            showLogs: true);
        pr.style(
            message: 'Pridobivam podatke iz API-ja.',
            borderRadius: 10.0,
            backgroundColor: Colors.white,
            progressWidget: CircularProgressIndicator(),
            elevation: 10.0,
            insetAnimCurve: Curves.easeInOut,
            progress: 0.0,
            maxProgress: 100.0,
            progressTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 13.0,
                fontWeight: FontWeight.w400),
            messageTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 19.0,
                fontWeight: FontWeight.w600)
        );
        pr.show();
        ApiDataGetter apiDataGetter = new ApiDataGetter();
        apiDataGetter.setGlobals();
        pr.update(
            message: "Potrpite malo! Podatki so skoraj že pridobljeni.",
            progressWidget: Container(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator()),
            maxProgress: 100.0,
            progressTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 13.0,
                fontWeight: FontWeight.w400),
            messageTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 19.0,
                fontWeight: FontWeight.w600),
        );
        pr.hide();
    }
}