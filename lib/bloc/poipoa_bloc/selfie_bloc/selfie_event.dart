import 'package:equatable/equatable.dart';
import 'dart:io';
import 'package:flutter/material.dart';

abstract class SelfieEvent extends Equatable{}

class AddSelfieEvent extends SelfieEvent{
  File img;

  AddSelfieEvent({@required this.img});
  @override
  // TODO: implement props
  List<Object> get props =>[img];
}


class CheckSelfieEvent extends SelfieEvent{
  File img;

  CheckSelfieEvent();
  @override
  // TODO: implement props
  List<Object> get props =>[];
}


