import 'package:equatable/equatable.dart';
import 'dart:io';
import 'package:flutter/material.dart';

abstract class PanEvent extends Equatable{}

class AddPanEvent extends PanEvent{
  File img;

  AddPanEvent({@required this.img});
  @override
  // TODO: implement props
  List<Object> get props =>[img];
}


class CheckPanEvent extends PanEvent{

  CheckPanEvent();
  @override
  // TODO: implement props
  List<Object> get props =>[];
}



