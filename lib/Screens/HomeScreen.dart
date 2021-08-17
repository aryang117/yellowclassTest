import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:yellowclassactual/Screens/addToDBForm.dart';

import '/Models/movieDB.dart';

int index = 0;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void addtoBox() {
    final MovieDB _newValueToAdd =
        MovieDB('movieName$index', "directorName$index");
    index++;
    setState(() {
      Hive.box('movieDB').add(_newValueToAdd);
    });
  }

  void updateDB(int _index, MovieDB _updatedValue) {
    setState(() {
      Hive.box('movieDB').putAt(_index, _updatedValue);
    });
  }

  void deleteValuesDB(int _index) {
    setState(() {
      Hive.box('movieDB').deleteAt(_index);
    });
  }

  void _clearAllValues() {
    setState(() {
      Hive.box('movieDB').clear();
    });
  }

  void reload() {
    setState(() {
      print('list refreshed');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 0),
        child: SingleChildScrollView(
          child: Column(children: [
            // Text(Hive.box('movieDB').values.last),
            SizedBox(
                height: MediaQuery.of(context).size.height - 50,
                child: _movieListBuilder(context, updateDB, deleteValuesDB)),
            Row(children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    print('reload');
                  });
                },
                icon: Icon(Icons.replay_outlined),
              ),
              IconButton(
                onPressed: _clearAllValues,
                icon: Icon(Icons.clear_all_rounded),
              )
            ]),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        isExtended: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        backgroundColor: Colors.black,
        child: Icon(
          Icons.add,
          size: 36,
        ),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddToDBForm()));
        },
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
    );
  }
}

ListView _movieListBuilder(
    BuildContext _context, Function _updatedDB, Function _deleteValueFromDB) {
  final _movieBox = Hive.box('movieDB');
  return ListView.builder(
    itemBuilder: (_context, _index) {
      final _movieDB = _movieBox.getAt(_index) as MovieDB;

      return Container(
        padding: const EdgeInsets.only(top: 20),
        height: 100,
        child: ListTile(
          leading: _thumbnailMaker(),
          horizontalTitleGap: 20,
          title: Text(_movieDB.movieName,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black)),
          subtitle: Text(_movieDB.directorName,
              style: TextStyle(
                fontSize: 14,
              )),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                color: Colors.black,
                icon: Icon(Icons.edit),
                onPressed: () {
                  _updatedDB(
                      _index, MovieDB('hehe $_index', 'directorName $_index'));
                },
              ),
              IconButton(
                color: Colors.black,
                icon: Icon(Icons.delete),
                onPressed: () {
                  _deleteValueFromDB(_index);
                },
              )
            ],
          ),
        ),
      );
    },
    itemCount: _movieBox.length,
  );
}

Widget _thumbnailMaker() {
  return ClipRRect(
    borderRadius: BorderRadius.circular(5),
    child: Image.network(
      'https://cdn.mos.cms.futurecdn.net/j6reMf3QEuGWFE7FkVmoyT-1200-80.jpg',
      fit: BoxFit.fitHeight,
      height: 250,
      width: 75,
      //width: 50,
    ),
  );
}
