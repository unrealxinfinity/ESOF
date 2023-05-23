import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:es/Viewer/NationalMenu.dart';
import 'package:es/Viewer/BugetMenu.dart';
import 'package:es/Viewer/SavingsMenu.dart';
import 'package:es/Viewer/SettingsMenu.dart';
import 'package:es/Viewer/StatisticsMenu.dart';
import 'package:es/Viewer/SwipableCharts.dart';
import 'package:es/database/RemoteDBHelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'CategoriesMenu.dart';
import 'TransactionsMenu.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/foundation.dart';
import 'package:es/Viewer/CategoriesMenu.dart';
import 'package:es/Viewer/ChartsMenu.dart';
import 'package:es/Viewer/TransactionsMenu.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  RemoteDBHelper remoteDBHelper = RemoteDBHelper(
      userInstance: FirebaseAuth.instance,
      firebaseInstance: FirebaseFirestore.instance);
  static String _currency = '';

  @override
  Widget build(BuildContext context) {
    setSettings(remoteDBHelper.getCurrency(), setState);
    return Scaffold(
        key: const Key("Main"),
        backgroundColor: const Color.fromARGB(255, 12, 18, 50),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(
                height: 25,
              ),
              Align(
                  alignment: Alignment.topRight,
                  child: FloatingActionButton(
                    key: const Key("Settings"),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const SettingsMenu(title: 'Settings')));
                    },
                    child: const Icon(Icons.settings),
                  )),
              const SizedBox(height: 20),
              const Text('FORTUNEKO',
                  style: TextStyle(
                      fontSize: 60,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 20,
              ),
              Image.asset(
                'assets/img/Luckycat1.png',
                width: 250,
              ),
              ElevatedButton(
                  key: const Key("Transactions"),
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(250, 35)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TransactionsMenu(
                                title: 'Transactions',
                                currency: _currency,
                              )),
                    );
                  },
                  child: const Text('Transactions',
                      style: TextStyle(fontSize: 20))),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(250, 35)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const CategoriesMenu(title: 'Categories')),
                    );
                  },
                  child:
                      const Text('Categories', style: TextStyle(fontSize: 20))),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const BudgetMenu(title: 'Budget')),
                  );
                },
                style:
                    ElevatedButton.styleFrom(minimumSize: const Size(250, 35)),
                child: Text('Budget', style: TextStyle(fontSize: 20)),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(250, 35)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SavingsMenu(
                                title: 'Savings',
                                currency: _currency,
                              )),
                    );
                  },
                  child: const Text('Savings', style: TextStyle(fontSize: 20))),
              /*  ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(250, 35)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const ChartsMenu(title: 'Charts')),
                    );
                  },
                  child: const Text('Charts', style: TextStyle(fontSize: 20))),*/
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(250, 35)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NationalMenu(
                                title: 'National Comparison',
                                currency: _currency,
                              )),
                    );
                  },
                  child: const Text('National Comparison',
                      style: TextStyle(fontSize: 20))),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(250, 35)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SwipableCharts(
                                title: 'Statistics',
                                currency: _currency,
                              )),
                    );
                  },
                  child:
                      const Text('Statistics', style: TextStyle(fontSize: 20))),
            ],
          ),
        ));
  }

  void setSettings(Stream<String> stream, Function? callback) {
    stream.listen((event) {
      if (mounted) {
        callback!(() {
          if (event.isNotEmpty) {
            _currency = event.toString();
          } else {
            _currency = '';
          }
        });
      }
    });
  }
}
