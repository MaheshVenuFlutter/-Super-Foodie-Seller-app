import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:seller_app_new/global/global.dart';

import 'package:seller_app_new/models/menus_model.dart';

import '../mainScreens/item_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class InfoDesignWidget extends StatefulWidget {
  Menus? model;
  BuildContext? context;

  InfoDesignWidget({
    this.model,
    this.context,
  });

  @override
  State<InfoDesignWidget> createState() => _InfoDesignWidgetState();
}

class _InfoDesignWidgetState extends State<InfoDesignWidget> {
  deleteMenu(String menuID) {
    FirebaseFirestore.instance
        .collection("sellers")
        .doc(sharedPreferences!.getString("uid"))
        .collection("menus")
        .doc(menuID)
        .delete();

    Fluttertoast.showToast(
        msg: "Menu Deleted Successfully.", backgroundColor: Colors.amber);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (c) => ItemsScreen(model: widget.model)));
      },
      splashColor: Colors.amber,
      child: Padding(
        padding: EdgeInsets.only(right: 10, left: 10, top: 10),
        child: Stack(
          children: [
            Positioned(
              child: Container(
                height: MediaQuery.of(context).size.height / 3.747,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Positioned(
                top: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height / 4.188,
                  width: MediaQuery.of(context).size.width / 1.0699,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                            widget.model!.thumbnailUrl!,
                          ),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(20)),
                )),
            Positioned(
              bottom: 5,
              child: Container(
                height: MediaQuery.of(context).size.height / 14.24, //50,
                width: MediaQuery.of(context).size.width / 1.0699,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.cyan, Colors.amber],
                        begin: FractionalOffset(0.0, 0.0),
                        end: FractionalOffset(1.0, 0.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFe8e8e8),
                        offset: Offset(0, 5),
                      ),
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(0, 0),
                      ),
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(0, 0),
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.model!.menuTitle!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width / 18,
                          fontFamily: "BebasNeue"),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 10,
              top: 10,
              child: Container(
                height: MediaQuery.of(context).size.height / 23.733,
                width: MediaQuery.of(context).size.width / 12,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: IconButton(
                    onPressed: () {
                      //delete the
                      deleteMenu(widget.model!.menuID!);
                    },
                    icon: Icon(
                      Icons.delete_sweep,
                      color: Colors.pinkAccent,
                      size: MediaQuery.of(context).size.width / 18,
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

/**Column(
            children: [
              const Divider(
                height: 10,
                thickness: 3,
                color: Colors.grey,
              ),
              Image.network(
                widget.model!.thumbnailUrl!,
                height: 200,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 1.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.model!.menuTitle!,
                    style: const TextStyle(
                        color: Colors.cyan, fontSize: 20, fontFamily: "Train"),
                  ),
                  IconButton(
                      onPressed: () {
                        //delete the
                        deleteMenu(widget.model!.menuID!);
                      },
                      icon: const Icon(
                        Icons.delete_sweep,
                        color: Colors.pinkAccent,
                        size: 20,
                      ))
                ],
              ),
              Text(
                widget.model!.menuInfo!,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),
            ],
          ), */
/** image: DecorationImage(
                        scale: 1.5,
                        image: NetworkImage(
                          widget.model!.thumbnailUrl!,
                        ),
                        fit: BoxFit.cover), */
