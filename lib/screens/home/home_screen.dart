import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_merojob/components/build_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> items = ["Home", "About", "Contact", "Blogs"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GridView Demo"),
        centerTitle: true,
      ),
      drawer: BuildDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Center(
              //   child: Text("hello"),
              // ),
              GridView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Container(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.1,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        25,
                      ),
                      color: Colors.blue,
                    ),
                    child: Center(
                      child: Text(
                        items[index],
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 4,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 10,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
