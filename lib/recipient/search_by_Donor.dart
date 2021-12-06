
import 'package:flutter/material.dart';
import 'package:flutternew/widget/serch_donor_wid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class DonorSearch extends StatefulWidget {
  static const routeName = '/searchdn';

  @override
  _DonorSearchState createState() => _DonorSearchState();
}

class _DonorSearchState extends State<DonorSearch> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Search Donors'),
      ),
      body: Column(
        children: [
          StreamBuilder(
            stream: Firestore.instance.collection('user').snapshots(),
            builder: (context, streamSnapshot) {
              if (streamSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final docs = streamSnapshot.data.documents;
              return Expanded(
                child: ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (ctx, index) {
                    return InkWell(
                      onTap: () {
                        
                        return Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return DonorSerWid(
                                docs[index]['uid'],
                                docs[index]['username'],
                                docs[index]['contact number'],
                                docs[index]['email id'],
                                docs[index]['type of user'],
                              );
                            },
                          ),
                        );
                      },
                      child: Card(
                        elevation: 5.0,
                        margin: EdgeInsets.all(5),
                        child: docs[index]['type of user'] == "Donor" ||
                                docs[index]['type of user'] == "donor"
                            ? ListTile(
                                title: Text(
                                  docs[index]['username'],
                                ),
                                leading: Icon(Icons.account_circle),
                              )
                            : Container(),
                      ),
                    );
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
