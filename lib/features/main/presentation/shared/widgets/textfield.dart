import 'package:flutter/material.dart';

const mytextfield = InputDecoration(
  suffixIcon: Icon(Icons.person),
  
  // To delete borders
  enabledBorder: OutlineInputBorder(borderSide: BorderSide.none,),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Color.fromARGB(255, 82, 63, 3),
    ),
  ),
  // fillColor: Colors.red,
  filled: true,
  contentPadding: EdgeInsets.all(8),
);
