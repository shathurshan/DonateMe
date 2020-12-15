import 'package:flutter/material.dart';

import './providers/events.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './pages/front_page.dart';
import './providers/data_store.dart';
import './pages/detail_page.dart';
import './pages/events_page.dart';
import './pages/tabs_bar_page.dart';
import './pages/adding_event_page.dart';
import './profile/profile_form.dart';
import 'package:flutternew/authendication/auth_page.dart';
import 'package:flutternew/recipient/front_recipient_page.dart';
import 'package:flutternew/recipient/search_by_Donor.dart';
import 'package:flutternew/recipient/search_by_map.dart';
import 'navigator/navigatorPage.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    void frontPage(){
      Firestore.instance.collection("users")
          .snapshots()
          .listen(
            (data) {
          if(data.documents[0]['email id'] == 'Donor')
          {
            return FrontPage();
          }
          return FrontRecipentPage();
        },
      );
    }
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Data(),
        ),
        ChangeNotifierProvider(
          create: (context) => Events(),
        ),
      ],
      child: MaterialApp(
        title: 'DonateeMe',
        theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.black,
          buttonTheme: ButtonTheme.of(context).copyWith(
            buttonColor: Colors.pink,
            textTheme: ButtonTextTheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),

        home: StreamBuilder(
            stream: FirebaseAuth.instance.onAuthStateChanged,
            builder: (ctx, userSnapshot) {
              if (userSnapshot.hasData) {
                return NavigatorPage();
              }
              return AuthPage();
            }),
        routes: {
          DetailPage.routeName: (context) => DetailPage(),
          EventsPage.routeName: (context) => EventsPage(),
          AddingEvent.routeName: (context) => AddingEvent(),
          ProfileForm.routeName: (context) => ProfileForm(),
          TabsPage.routeName: (context) =>  TabsPage(),
          FrontRecipentPage.routeName: (context) => FrontRecipentPage(),
          AuthPage.routName: (context) => AuthPage(),
          DonorSearch.routeName: (context) => DonorSearch(),
          SearchByMap.routeName: (context) => SearchByMap(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
