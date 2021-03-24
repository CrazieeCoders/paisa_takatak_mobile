import 'package:equatable/equatable.dart';
import 'dart:io';
import 'package:flutter/material.dart';

abstract class AadhaarFrontEvent extends Equatable{}

class AddAadhaarFrontEvent extends AadhaarFrontEvent{
  File img;

  AddAadhaarFrontEvent({@required this.img});
  @override
  // TODO: implement props
  List<Object> get props =>[img];
}



