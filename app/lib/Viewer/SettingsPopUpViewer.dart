import 'package:flutter/material.dart';
import 'package:es/database/LocalDBHelper.dart';
import 'package:quickalert/quickalert.dart';
import 'package:es/Controller/LoginScreenController.dart';

class SettingsPopUpViewer {
  void resetData(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("WARNING"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text("All your data will be deleted"),
                SizedBox(height: 5),
                Text("This action is irreversible"),
                SizedBox(height: 5),
                Text("Do you wish to continue?")
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("NO", style: TextStyle(color: Colors.lightBlue))),
              TextButton(
                  onPressed: () async {
                    if(await LocalDBHelper.instance.isLocalDBEmpty()){
                      Navigator.of(context).pop();
                      noData(context);
                    }
                    else{
                      LocalDBHelper.instance.deleteLocalDB();
                      Navigator.of(context).pop();
                      deletdData(context);
                    }
                  },
                  child: const Text("YES", style: TextStyle(color: Colors.lightBlue),))
            ],
          );
        });
  }

  void deletdData(BuildContext context) {
    QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: 'Miau miau!',
        text: 'Your data has been successfully deleted');
  }

  void noData(BuildContext context) {
    QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Miau...',
        text: 'No data has been inserted into the app');
  }

  void sureLogout(BuildContext context, loginScreenController loginController){
    QuickAlert.show(
        context: context,
        type: QuickAlertType.warning,
        title: 'WARNING',
        text: 'This is still a beta version. Therefore, once you logout, all your data will be deletd',
        confirmBtnColor: Colors.lightBlue,
        onConfirmBtnTap: () {
          loginController.signOut();
          loginController.toLogInScreen(context);
          QuickAlert.show(
              context: context,
              text: "Sucessfully logged out!",
              type: QuickAlertType.success);
        },
    );
  }
}