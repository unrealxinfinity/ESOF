import 'package:es/database/RemoteDBHelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Controller/NewTransactionController.dart';
import 'package:es/Model/TransactionsModel.dart' as t_model;
import 'package:es/Viewer/MapMenu.dart';

class TransactionsMenu extends StatefulWidget {
  const TransactionsMenu({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<TransactionsMenu> createState() => _TransactionsMenuState();
}

class _TransactionsMenuState extends State<TransactionsMenu> {
  RemoteDBHelper remoteDBHelper =
      RemoteDBHelper(userInstance: FirebaseAuth.instance);
  @override
  Widget build(BuildContext context) {
    NumberFormat euro = NumberFormat.currency(locale: 'pt_PT', name: "€");

    return Scaffold(
        backgroundColor: const Color.fromRGBO(20, 25, 46, 1.0),
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          title: Text(widget.title,
              style: const TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic)),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.home,
              color: Colors.white,
            ),
            onPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
          ),
          actions: [
            IconButton(
                onPressed: () {Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                        const MapMenu(title: 'Transactions Map',)));},
                icon: const Icon(
                  Icons.map_sharp,
                  color: Colors.white,
                ))
          ],
        ),
        body: Stack(
          children: [
            StreamBuilder<List<t_model.TransactionModel>>(
                stream: remoteDBHelper.readTransactions(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<t_model.TransactionModel>> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                        child: Text('Loading...',
                            style:
                                TextStyle(fontSize: 20, color: Colors.white)));
                  }
                  return snapshot.data!.isEmpty
                      ? const Center(
                          child: Text("Nothing to show",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)),
                        )
                      : ListView(
                          shrinkWrap: true,
                          children: snapshot.data!.map((transac) {
                            return Center(
                              child: Container(
                                decoration: const BoxDecoration(
                                    border: Border(
                                        bottom:
                                            BorderSide(color: Colors.white24))),
                                child: ListTile(
                                  textColor: Colors.white,
                                  iconColor: Colors.white,
                                  leading: (transac.expense == 1)
                                      ? const Icon(Icons.money_off)
                                      : const Icon(Icons.wallet),
                                  title: Text(
                                    transac.name,
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  subtitle: Text(DateFormat('dd-MM-yyyy')
                                      .format(transac.date)),
                                  trailing: Text(
                                    (transac.expense == 1 ? '-' : '+') +
                                        euro.format(transac.total),
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      NewTransactionController()
                                          .showTransaction(context);
                                    });
                                  },
                                  onLongPress: () {
                                    setState(() {
                                      remoteDBHelper.removeTransaction(transac);
                                    });
                                  },
                                ),
                              ),
                            );
                          }).toList(),
                        );
                }),
            Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: FloatingActionButton(
                      heroTag: "Filter",
                      onPressed: () {},
                      backgroundColor: Colors.lightBlue,
                      child: const Icon(Icons.filter_alt_rounded)),
                )),
            Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: FloatingActionButton(
                      heroTag: "Add",
                      onPressed: () {
                        NewTransactionController().newTransaction(context);
                      },
                      backgroundColor: Colors.lightBlue,
                      child: const Icon(Icons.add)),
                ))
          ],
        ));
  }
}
