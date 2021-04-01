import 'package:equatable/equatable.dart';
import 'dart:io';
import 'package:flutter/material.dart';

abstract class AadhaarBackEvent extends Equatable{}

class AddAadhaarBackEvent extends AadhaarBackEvent{
  File img;

  AddAadhaarBackEvent({@required this.img});
  @override
  // TODO: implement props
  List<Object> get props =>[img];
}


class CheckAadhaarBackEvent extends AadhaarBackEvent{

  CheckAadhaarBackEvent();
  @override
  // TODO: implement props
  List<Object> get props =>[];
}





