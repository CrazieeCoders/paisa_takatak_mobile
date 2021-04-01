import 'package:equatable/equatable.dart';
import 'dart:io';
import 'package:flutter/material.dart';

abstract class ChequeEvent extends Equatable{}

class AddChequeEvent extends ChequeEvent{
  File img;

  AddChequeEvent({@required this.img});
  @override
  // TODO: implement props
  List<Object> get props =>[img];
}


class CheckChequeEvent extends ChequeEvent{

  CheckChequeEvent();
  @override
  // TODO: implement props
  List<Object> get props =>[];
}



