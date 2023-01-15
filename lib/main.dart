/*import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Anket"),
        ),
        body: SurveyList(),
      ),
    );
  }
}

class SurveyList extends StatefulWidget {
  ///////////////
  @override
  State<StatefulWidget> createState() {
    return SurveyListState();
  }
}

class SurveyListState extends State {
  //////////////
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("dilanketi").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        } else if (!snapshot.hasData) {
          return LinearProgressIndicator();
        } /*else {
          return buildBody(context, snapshot.data!.docs);
        } */
        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return ListTile(
              title: Text(data['isim']),
              trailing: Text(data['oy']),
            );
          }).toList(),
        );
      },
    );
  }

  /*Widget buildBody(BuildContext context, List<DocumentSnapshot> snapshot) {
    //////
    return ListView(
      padding: EdgeInsets.only(top: 20.0),
      children:
          snapshot.map<Widget>((data) => buildListItem(context, data)).toList(),
    );
  }*/

  /*buildListItem(BuildContext context, DocumentSnapshot data) {
    final row = Anket.fromSnapShot(data);
    return Padding(
      key: ValueKey(row.isim),
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(row.isim!),
          trailing: Text(row.oy!.toString()),
          onTap: () => row.reference!.update({"oy": row.oy! + 1}),
        ),
      ),
    );
  }*/
}

/*final sahteSnapshot = [
  {"isim": "C#", "oy": 10},
  {"isim": "Java", "oy": 5},
  {"isim": "C++", "oy": 1},
  {"isim": "Dart", "oy": 8},
  {"isim": "python", "oy": 5},
  {"isim": "Perl", "oy": 2},
];*/

/*class Anket {
  String? isim;
  int? oy;
  DocumentReference? reference;

  Anket.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map["isim"] != null),
        assert(map["oy"] != null),
        isim = map["isim"],
        oy = map["oy"];

  Anket.fromSnapShot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data as Map<String, dynamic>,
            reference: snapshot.reference);
}*/
*/

import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Anket"),
        ),
        body: UserInformation(),
      ),
    );
  }
}

/*class AddUser extends StatelessWidget {
  final String isim;
  final int oy;

  AddUser(this.isim, this.oy);

  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection
    CollectionReference users =
        FirebaseFirestore.instance.collection('dilanketi');

    Future<void> addUser() {
      // Call the user's CollectionReference to add a new user
      return users
          .add({
            'isim': isim, // John Doe
            'oy': oy // 42
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    return Center(
      child: TextButton(
        onPressed: addUser,
        child: Text(
          "Add",
        ),
      ),
    );
  }
}*/

class UserInformation extends StatefulWidget {
  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('dilanketi').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return Center(
          child: ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return ListTile(
                title: Text(data['isim']),
                subtitle: Text(data['oy'].toString()),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
