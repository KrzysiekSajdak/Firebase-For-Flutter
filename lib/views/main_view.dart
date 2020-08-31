import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final dummySnapshot = [
  {"name": "Filip", "votes":15},
  {"name": "Max", "votes":15},
  {"name": "Emi", "votes":15},
  {"name": "Chris", "votes":15},
  {"name": "Nick", "votes":15}
];

class MainView extends StatefulWidget {

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter Firebase"),),
      body: _buildBody(context),
    );
  }
}
Widget _buildBody(BuildContext context) {
//  return _buildList(context, dummySnapshot);
return StreamBuilder<QuerySnapshot>(
  stream: FirebaseFirestore.instance.collection("baby").snapshots(),
  builder: (context, snapshot) {
    if (!snapshot.hasData) return LinearProgressIndicator();
    return _buildList(context, snapshot.data.documents);
  },
);

}
Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
  return ListView(
    padding: const EdgeInsets.only(top: 20),
    children:
      snapshot.map((data) => _buildListItem(context, data)).toList(),

  );
}
Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
  final record = Record.fromSnapshot(data);
  return Padding(
    key: ValueKey(record.name),
    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: ListTile(
        title: Text(record.name),
        trailing: Text(record.votes.toString()),
        onTap: () => record.reference.update({"votes" : FieldValue.increment(1)}) ,
      ),
    ),
  );
}

class Record {
  final String name;
  final int votes;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference}) :
  assert(map["name"] != null),
  assert(map["votes"] != null),
  name = map["name"],
  votes = map["votes"];

  Record.fromSnapshot(DocumentSnapshot snapshot) : this.fromMap(snapshot.data(), reference: snapshot.reference);

  @override

  String toString() => "Record<$name:$votes>";
}


