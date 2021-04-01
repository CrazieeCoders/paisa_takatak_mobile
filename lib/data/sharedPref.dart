import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs{

  static SharedPreferences _sharedPrefs;

  init()async{
    if(_sharedPrefs == null){
      _sharedPrefs = await SharedPreferences.getInstance();
    }
  }

  setLoanStatus(int x){
    _sharedPrefs.setInt('loanStatus', 1);
  }


  String  get getPhone => _sharedPrefs.getString("phNo")?? null;

  int  get getLoanStatus => _sharedPrefs.getInt("loanStatus")?? 0;

  int  get getSelfieStatus => _sharedPrefs.getInt("selfieStatus")?? 0;

  int  get getpanCardStatus => _sharedPrefs.getInt("panCard")?? 0;

  int  get getAadharFrontStatus => _sharedPrefs.getInt("aadharFront")?? 0;

  int  get getAadharBackStatus => _sharedPrefs.getInt("aadharBack")?? 0;

  int  get getChequeStatus => _sharedPrefs.getInt("cancelledCheque")?? 0;

  String  get getAuthorizationToken => _sharedPrefs.getString("token")?? 0;


  setSelfieStatus(int selfiePhoto){
    _sharedPrefs.setInt('selfieStatus',selfiePhoto);
  }

  setPanStatus(int pancard){
    _sharedPrefs.setInt('panCard',pancard);
  }

  setAadharFrontStatus(int aadharCardFront){
    _sharedPrefs.setInt('aadharFront',aadharCardFront);
  }

  setAadharBackStatus(int aadharCardBack){
    _sharedPrefs.setInt('aadharBack',aadharCardBack);
  }

  setChequeStatus(int cancelledCheque){
    _sharedPrefs.setInt('cancelledCheque',cancelledCheque);
  }

  setAuthorizationToken(String token){
    _sharedPrefs.setString('token',token);
  }


}