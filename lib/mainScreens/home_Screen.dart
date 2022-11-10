import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:seller_app_new/global/global.dart';
import 'package:seller_app_new/models/menus_model.dart';
import 'package:seller_app_new/uploadsScreens/menu_upload_screen.dart';
import 'package:seller_app_new/widgets/info_design.dart';
import 'package:seller_app_new/widgets/my_drawer.dart';
import 'package:seller_app_new/widgets/text_widget_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBackButtenPressed(context),
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.cyan, Colors.amber],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
          ),
          title: Text(
            sharedPreferences!.getString(
              "name",
            )!,
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.width / 14.4,
                fontFamily: "Lobster"),
          ),
          centerTitle: true,
          automaticallyImplyLeading: true,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (c) => const MenusUpLoadScreen()));
                },
                icon: const Icon(
                  Icons.post_add,
                  color: Colors.white,
                ))
          ],
        ),
        drawer: MyDrawer(),
        body: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
                pinned: true, delegate: TextWidgetHeader(title: "My Menus")),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("sellers")
                  .doc(sharedPreferences!.getString("uid"))
                  .collection("menus")
                  .orderBy(
                    "publishedDate",
                    descending: true,
                  )
                  .snapshots(),
              builder: (context, snapshot) {
                return !snapshot.hasData
                    ? const SliverToBoxAdapter(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : SliverStaggeredGrid.countBuilder(
                        crossAxisCount: 1,
                        staggeredTileBuilder: (c) => StaggeredTile.fit(1),
                        itemBuilder: (context, index) {
                          Menus model = Menus.fromJson(
                              snapshot.data!.docs[index].data()!
                                  as Map<String, dynamic>);
                          return InfoDesignWidget(
                            model: model,
                            context: context,
                          );
                        },
                        itemCount: snapshot.data!.docs.length,
                      );
              },
            )
          ],
        ),
      ),
    );
  }
}

Future<bool> _onBackButtenPressed(BuildContext context) async {
  bool exitApp = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: const Text(
            "Do you want to close the app ?",
            style: TextStyle(
                fontFamily: "KiwiMaru",
                fontSize: 15,
                color: Colors.black87,
                fontWeight: FontWeight.bold),
          ),
          title: const Text(
            "Really ??",
            style: TextStyle(
                fontFamily: "KiwiMaru",
                fontSize: 22,
                color: Colors.black87,
                fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text(
                  "No",
                  style: TextStyle(fontSize: 30, color: Colors.blueAccent),
                )),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text(
                  "Yes",
                  style: TextStyle(fontSize: 30, color: Colors.blueAccent),
                )),
          ],
        );
      });

  return exitApp;
}
