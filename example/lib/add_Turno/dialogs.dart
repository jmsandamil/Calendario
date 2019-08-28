import 'dart:async';
import 'dart:io';

import 'package:table_calendar_example/models/turno.dart';

import 'add_dialog.dart';


import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';



class Dialogs {
  
  static Future showThemedDialog(BuildContext context, Widget child) async {
    return await showDialog(context: context, 
      builder: (BuildContext context) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: MediaQuery.of(context).size.width * 1.0,
              height: MediaQuery.of(context).size.height * 1.0,
              color: Colors.black.withOpacity(0.4),
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Stack(
                  children:[
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(color: Colors.transparent),
                    ),
                    Column( 
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(Platform.isIOS ? 10.0 : 0.0)),
                            color: Colors.white
                          ),
                          child: child
                        )
                      ]
                    )
                  ]
                )
              )
            )
          )    
        );
      }
    );
  }

  static Future showMessage(BuildContext context, String title, String body, String ok){
    return showThemedDialog(context, 
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 20.0, left: 40.0, right: 40.0),
            child: Text(title,
              style: TextStyle(
                fontSize: 18.0,
                fontFamily: 'Gilroy-Bold',
              )
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20.0, left: 30.0, right: 30.0),
            child: Text(body,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                fontFamily: 'Gilroy'
              )
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Text(ok,
                style: TextStyle(
                  fontFamily: 'Gilroy-ExtraBold',
                  color: Colors.blue,
                  fontSize: 18.0
                ),
              ),
            ),
          ) 
        ],
      )
    );
  }

  static Future showAddToCalendar(BuildContext context, {Turno turno1, CalendarItem calendarItem}){
    return showThemedDialog(context,
      AddToCalendarDialog(
        turno: turno1,
        calendarItem: calendarItem,
      )
    );
  }

  static Future showYesNo(BuildContext context, String title, String body, String yes, String no, {Function onYes, Function onNo}){
    return showThemedDialog(context, 
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 20.0, left: 60.0, right: 60.0),
            child: Text(title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.0,
                fontFamily: 'Gilroy-Bold',
              )
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 30.0, left: 30.0, right: 30.0),
            child: Text(body,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                fontFamily: 'Gilroy'
              )
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 30.0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: InkWell(
                  onTap: (){
                    if (onNo != null){
                      onNo();
                    }
                    Navigator.pop(context);
                  },
                  child: Text(no,
                    style: TextStyle(
                      fontFamily: 'Gilroy-ExtraBold',
                      color: Colors.grey,
                      fontSize: 18.0
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: InkWell(
                  onTap: (){
                    if (onYes != null){
                      onYes();
                    }
                    Navigator.pop(context);
                  },
                  child: Text(yes,
                    style: TextStyle(
                      fontFamily: 'Gilroy-ExtraBold',
                  color: Colors.blue,
                      fontSize: 18.0
                    ),
                  ),
                ),
              )
            ]
          )
        ],
      )
    );
  }
  
}