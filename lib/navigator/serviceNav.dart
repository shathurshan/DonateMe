import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutternew/pages/tabs_bar_page.dart';
import 'package:flutternew/recipient/front_recipient_page.dart';
class UserNavigation {
  accessUser(BuildContext context) {
    FirebaseAuth.instance.currentUser().then(
      (user) {
        Firestore.instance
            .collection('/user')
            .where('uid', isEqualTo: user.uid)
            .getDocuments()
            .then(
          (docs) {
            if (docs.documents.isNotEmpty) {
              if (docs.documents[0].exists) {
                if (docs.documents[0]['type of user'] == 'Donor' ||
                    docs.documents[0]['type of user'] == 'donor') {
                  Navigator.of(context).pushNamed(TabsPage.routeName);
                } else if (docs.documents[0]['type of user'] == 'Recipient' ||
                    docs.documents[0]['type of user'] == 'recipient') {
                  Navigator.of(context).pushNamed(FrontRecipentPage.routeName);
                } else {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Your Not Authorized',
                      ),
                    ),
                  );
                }
              }
            }
          },
        );
      },
    );
  }
}
