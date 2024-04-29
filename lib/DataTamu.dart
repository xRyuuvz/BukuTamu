  import 'package:flutter/material.dart';

  import 'Header.dart';
  import 'InputWrapper.dart';

  class DataTamu extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
              Colors.redAccent,
              Colors.red,
              Colors.black12
            ]),
          ),
          child: Column(
            children: <Widget>[
              SizedBox(height: 100,),
              Header(),
              Expanded(child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(80),
                      topRight:  Radius.circular(80),
                    )
                ),
                child: InputWrapper(),
              ))
            ],
          ),
        ),
      );
    }
  }