import 'package:equatable/equatable.dart';
import 'dart:io';
import 'package:flutter/material.dart';

abstract class BankStatEvent extends Equatable{}

class AddBankStatEvent extends BankStatEvent{
  File img;

  AddBankStatEvent({@required this.img});
  @override
  // TODO: implement props
  List<Object> get props =>[img];
}


class CheckBankStatEvent extends BankStatEvent{

  CheckBankStatEvent();
  @override
  // TODO: implement props
  List<Object> get props =>[];
}



