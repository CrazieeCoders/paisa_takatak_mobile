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

  int  get getBankStatementStatus => _sharedPrefs.getInt("bankStatement")?? 0;

  int  get getLoanApplicationForm => _sharedPrefs.getInt("loanApplicationForm")?? 0;

  int  get getLoanAgreementSigned => _sharedPrefs.getInt("loanAgreementSigned")?? 0;

  int  get getHouseHoldStatus => _sharedPrefs.getInt("houseHoldStatus")?? 0;

  int  get getHouseHoldFlag => _sharedPrefs.getInt("houseHoldFlag")?? 0;

  int  get getLoanApplicationUnderProcess => _sharedPrefs.getInt("loanApplicationUnderProcess")?? 0;

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

  setBankStatementStatus(int bankStatement){
    _sharedPrefs.setInt('bankStatement',bankStatement);
  }


  setLoanApplicationForm(int loanApplicationForm){
    _sharedPrefs.setInt('loanApplicationForm',loanApplicationForm);
  }

  setLoanAgreementSigned(int loanAgreementSigned){
    _sharedPrefs.setInt('loanAgreementSigned',loanAgreementSigned);
  }

  setHouseholdStatus(int houseHoldStatus){
    _sharedPrefs.setInt('houseHoldStatus',houseHoldStatus);
  }

  setHouseholdFlag(int houseHoldFlag){
    _sharedPrefs.setInt('houseHoldFlag',houseHoldFlag);
  }


  setLoanApplicationUnderProcess(int loanApplicationUnderProcess){
  _sharedPrefs.setInt('loanApplicationUnderProcess',loanApplicationUnderProcess);
  }

  setAuthorizationToken(String token){
    _sharedPrefs.setString('token',token);
  }





}