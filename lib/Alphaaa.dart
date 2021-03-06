import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_database/screens/add_contacts.dart';
//import 'package:flutter_database/screens/edit_contact.dart';

class Deeb extends StatefulWidget {
  @override
  _ContactsState createState() => _ContactsState();
}

class _ContactsState extends State<Deeb> {
  Query _ref;
  DatabaseReference reference =
      FirebaseDatabase.instance.reference().child('rashad');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ref = FirebaseDatabase.instance
        .reference()
        .child('rashad')
        .orderByChild('category');
  }

  Widget _buildContactItem({Map rashad}) {
    Color typeColor = getTypeColor(rashad['type']);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(10),
      height: 422,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: 30,height: 30,
              ),
               Expanded(
                child: Text(
                rashad['category'],
                style: TextStyle(
                    fontSize: 20,
                   color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w900),
              ),
              ),
              
            ],
          ),
          SizedBox(
           width: 40,height: 40,
          ),
          Row(
            children: [
              
              FittedBox(
              
              ),
            Expanded(
                child: Text(
                rashad['zekr'],
                style: TextStyle(
                    fontSize: 16,
                   color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600),
              ),
              ),
            ],
          ),
              SizedBox(width: 30,height: 30,),
           // description
              Row(
            children: [
              
              SizedBox(
               width: 40,height: 40,
              ),
            Expanded(
                child: Text(
                rashad['description'],
                style: TextStyle(
                    fontSize: 15,
                   color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600),
              ),
              ),
            ],
          ),
            ],
      ) ,
              );
       
            
  }

  _showDeleteDialog({Map contact}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Delete ${contact['name']}'),
            content: Text('Are you sure you want to delete?'),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
              FlatButton(
                  onPressed: () {
                    reference
                        .child(contact['key'])
                        .remove()
                        .whenComplete(() => Navigator.pop(context));
                  },
                  child: Text('Delete'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Azkar'),
      ),
      body: Container(
        height: double.infinity,
        child: FirebaseAnimatedList(
          query: _ref,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            Map contact = snapshot.value;
            contact['key'] = snapshot.key;
            return _buildContactItem(rashad: contact);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          /*Navigator.push(
            context,
            MaterialPageRoute(builder: (_) {
              return AddContacts();
            }),
          );*/
        },
        //child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Color getTypeColor(String type) {
    Color color = Theme.of(context).accentColor;

    if (type == 'Work') {
      color = Colors.brown;
    }

    if (type == 'Family') {
      color = Colors.green;
    }

    if (type == 'Friends') {
      color = Colors.teal;
    }
    return color;
  }
}
