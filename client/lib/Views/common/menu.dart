import 'package:flutter/material.dart';

class Common {
  Drawer drawer() {
    return Drawer(
      width: 180,
      backgroundColor: Colors.blueGrey,
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          SizedBox(
            height: 90,
            child: DrawerHeader(
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
              decoration: const BoxDecoration(color: Colors.black38),
              child: Column(
                children: const [
                  SizedBox(height: 10),
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: SizedBox(
                        height: 53,
                        width: 53,
                        child: CircleAvatar(
                          backgroundColor: Colors.blueGrey,
                          child: Text(
                            'R',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const ListTile(
            leading: Icon(Icons.settings),
            title: Text(
              '设置',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
    ;
  }
}
