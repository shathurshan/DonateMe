import 'package:flutter/material.dart';
import 'package:flutternew/widget/app_drawre_widget.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';

class InvitePage extends StatefulWidget {
  @override
  _InvitePageState createState() => _InvitePageState();
}

class _InvitePageState extends State<InvitePage> {
  List<Contact> contacts = [];
  List<Contact> contactsFiltered = [];
  Map<String, Color> contactsColorMap = new Map();
  TextEditingController searchController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    getPermissions();
  }
  getPermissions() async {
    if (await Permission.contacts.request().isGranted) {
      getAllContacts();
      searchController.addListener(() {
        filterContacts();
      });
    }
  }

  String flattenPhoneNumber(String phoneStr) {
    return phoneStr.replaceAllMapped(RegExp(r'^(\+)|\D'), (Match m) {
      return m[0] == "+" ? "+" : "";
    });
  }

  getAllContacts() async {
    List colors = [
      Colors.green,
      Colors.indigo,
      Colors.yellow,
      Colors.orange
    ];
    int colorIndex = 0;
    List<Contact> _contacts = (await ContactsService.getContacts(withThumbnails: false)).toList();
    _contacts.forEach((contact) {
      Color baseColor = colors[colorIndex];
      contactsColorMap[contact.displayName] = baseColor;
      colorIndex++;
      if (colorIndex == colors.length) {
        colorIndex = 0;
      }
    });
    setState(() {
      contacts = _contacts;
    });
  }

  filterContacts() {
    List<Contact> _contacts = [];
    _contacts.addAll(contacts);
    if (searchController.text.isNotEmpty) {
      _contacts.retainWhere((contact) {
        String searchTerm = searchController.text.toLowerCase();
        String searchTermFlatten = flattenPhoneNumber(searchTerm);
        String contactName = contact.displayName.toLowerCase();
        bool nameMatches = contactName.contains(searchTerm);
        if (nameMatches == true) {
          return true;
        }

        if (searchTermFlatten.isEmpty) {
          return false;
        }

        var phone = contact.phones.firstWhere((phn) {
          String phnFlattened = flattenPhoneNumber(phn.value);
          return phnFlattened.contains(searchTermFlatten);
        }, orElse: () => null);

        return phone != null;
      });
    }
    setState(() {
      contactsFiltered = _contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isSearching = searchController.text.isNotEmpty;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Invite page"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Container(
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                    labelText: 'Search',
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(
                            color: Theme.of(context).primaryColor
                        )
                    ),
                    prefixIcon: Icon(
                        Icons.search,
                        color: Theme.of(context).primaryColor
                    )
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: isSearching == true ? contactsFiltered.length : contacts.length,
                itemBuilder: (context, index) {
                  Contact contact = isSearching == true ? contactsFiltered[index] : contacts[index];

                  var baseColor = contactsColorMap[contact.displayName] as dynamic;

                  Color color1 = baseColor[800];
                  Color color2 = baseColor[400];
                  return ListTile(
                      title: new Text(contact.displayName != null ?contact.displayName : ""),
                      subtitle: Text( contact.phones != null &&
                          contact.phones.length > 0 ? contact.phones.elementAt(0).value : ''
                      ),
                      leading: (contact.avatar != null && contact.avatar.length > 0) ?
                      CircleAvatar(
                        backgroundImage: MemoryImage(contact.avatar != null ?contact.avatar: ''),
                      ) :
                      Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                  colors: [
                                    color1,
                                    color2,
                                  ],
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight
                              )
                          ),
                          child: CircleAvatar(
                              child: Text(
                                  contact.initials(),
                                  style: TextStyle(
                                      color: Colors.white
                                  )
                              ),
                              backgroundColor: Colors.transparent
                          )
                      )
                  );
                },
              ),
            )
          ],
        ),
      ),
      drawer: AppDrawerWid(),
    );
  }
}
