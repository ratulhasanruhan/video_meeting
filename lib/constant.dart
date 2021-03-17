import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle mystyle(double size,[Color color, FontWeight fontWeight = FontWeight.w700]){
  return GoogleFonts.montserrat(
    fontSize: size,
    color: color,
    fontWeight: fontWeight,
  );
}

CollectionReference userCollection =
    FirebaseFirestore.instance.collection('user');