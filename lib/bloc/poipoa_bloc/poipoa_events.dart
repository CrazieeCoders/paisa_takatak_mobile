import 'package:equatable/equatable.dart';
import 'dart:io';
import 'package:flutter/material.dart';

abstract class POIPOAEvent extends Equatable{}

class SelfieEvent extends POIPOAEvent{
  File img;

  SelfieEvent({@required this.img});
  @override
  // TODO: implement props
  List<Object> get props =>[img];
}


