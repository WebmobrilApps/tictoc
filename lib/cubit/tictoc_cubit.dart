
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictoc/repository/response_status.dart';
import 'package:tictoc/repository/tictoc_repository.dart';


part 'tictoc_state.dart';





class TicTocCubit extends Cubit<TicTocState> {
  final TicTocRepository repository;

  TicTocCubit(this.repository) : super(const TicTocState());


  Future<void> signUpCall(Map<String,dynamic> signUpDetails) async{
    emit(state.copyWith(status: TicTocStatus.signUpLoading));
    try{
      ResponseData responseData = await repository.signUp(signUpDetails);
      emit(state.copyWith(status: TicTocStatus.signUpSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: TicTocStatus.signUpError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: TicTocStatus.signUpError,error: e.toString(),errorData: null));
    }
  }
  Future<void> registerOTPVerifyCall(String otp,String token) async{
    emit(state.copyWith(status: TicTocStatus.registerVerifyOTPLoading));
    try{
      ResponseData responseData = await repository.registerOTPVerify(otp,token);
      emit(state.copyWith(status: TicTocStatus.registerVerifyOTPSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: TicTocStatus.registerVerifyOTPError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: TicTocStatus.registerVerifyOTPError,error: e.toString(),errorData: null));
    }
  }
  Future<void> signInCall(Map<String,dynamic> signInDetails) async {
    emit(state.copyWith(status: TicTocStatus.signInLoading));
    try {
      ResponseData response = await repository.signIn(signInDetails);
      emit(state.copyWith(status: TicTocStatus.signInSuccess, responseData: response));
    }
    on ErrorData catch (errorData) {
      emit(state.copyWith(status: TicTocStatus.signInError, errorData: errorData, error: null));
    }
    catch (e) {
      emit(state.copyWith(status: TicTocStatus.signInError, error: e.toString(), errorData: null));
    }
  }


  Future<void> guestLoginCall(Map<String,dynamic> signInDetails) async {
    emit(state.copyWith(status: TicTocStatus.guestLoginLoading));
    try {
      ResponseData response = await repository.guestLogin(signInDetails);
      emit(state.copyWith(status: TicTocStatus.guestLoginSuccess, responseData: response));
    }
    on ErrorData catch (errorData) {
      emit(state.copyWith(status: TicTocStatus.guestLoginError, errorData: errorData, error: null));
    }
    catch (e) {
      emit(state.copyWith(status: TicTocStatus.guestLoginError, error: e.toString(), errorData: null));
    }
  }

  Future<void> forgotPasswordCall(String emailOrPhone) async {
    emit(state.copyWith(status: TicTocStatus.forgotPasswordLoading));
    try {
      ResponseData response = await repository.forgotPassword(emailOrPhone);
      emit(state.copyWith(status: TicTocStatus.forgotPasswordSuccess, responseData: response));
    }
    on ErrorData catch (errorData) {
      emit(state.copyWith(status: TicTocStatus.forgotPasswordError, errorData: errorData, error: null));
    }
    catch (e) {
      emit(state.copyWith(status: TicTocStatus.forgotPasswordError, error: e.toString(), errorData: null));
    }
  }

  Future<void> resendVerifyOTPCall(String token) async{
    emit(state.copyWith(status: TicTocStatus.resendVerifyOTPLoading));
    try{
      ResponseData responseData = await repository.resendVerifyOtp(token);
      emit(state.copyWith(status: TicTocStatus.resendVerifyOTPSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: TicTocStatus.resendVerifyOTPError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: TicTocStatus.resendVerifyOTPError,error: e.toString(),errorData: null));
    }
  }

  Future<void> resetPasswordCall(String token,String newPassword,String confirmPassword) async{
    emit(state.copyWith(status: TicTocStatus.resetPasswordLoading));
    try{
      ResponseData responseData = await repository.resetPassword(token, newPassword, confirmPassword);
      emit(state.copyWith(status: TicTocStatus.resetPasswordSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: TicTocStatus.resetPasswordError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: TicTocStatus.resetPasswordError,error: e.toString(),errorData: null));
    }
  }
  Future<void> userInterestCall(Map<String,dynamic> interestList, String tmpToken) async{
    emit(state.copyWith(status: TicTocStatus.userInterestLoading));
    try{
      ResponseData responseData = await repository.userInterest(interestList,tmpToken);
      emit(state.copyWith(status: TicTocStatus.userInterestSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: TicTocStatus.userInterestError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: TicTocStatus.userInterestError,error: e.toString(),errorData: null));
    }
  }
  Future<void> getProfileCall() async{
    emit(state.copyWith(status: TicTocStatus.getProfileLoading));
    try{
      ResponseData responseData = await repository.getProfile();
      emit(state.copyWith(status: TicTocStatus.getProfileSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: TicTocStatus.getProfileError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: TicTocStatus.getProfileError,error: e.toString(),errorData: null));
    }
  }
  Future<void> updateProfileCall(File? image, String name, String link,String bio) async{
    emit(state.copyWith(status: TicTocStatus.updateProfileLoading));
    try{
      ResponseData responseData = await repository.updateProfile(image, name, link, bio);
      emit(state.copyWith(status: TicTocStatus.updateProfileSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: TicTocStatus.updateProfileError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: TicTocStatus.updateProfileError,error: e.toString(),errorData: null));
    }
  }
/*
  Future<void> getProfileCall() async {
    emit(state.copyWith(status: TicTocStatus.getProfileLoading));

    try {
      ResponseData responseData = await repository.getProfile();
      emit(state.copyWith(status: TicTocStatus.getProfileSuccess, responseData: responseData));
    }
    on ErrorData catch (errorData) {
      print('Error Message: ${errorData.message}');
      print('Error Status Code: ${errorData.code}');
      emit(state.copyWith(status: TicTocStatus.getProfileError, errorData: errorData, error: null));
    }
    catch (e) {
      print('Unhandled Error: $e');
      emit(state.copyWith(status: TicTocStatus.getProfileError, error: e.toString(), errorData: null));
    }
  }*/

/*  Future<void> registerOTPVerifyCall(String otp,String token) async{
    emit(state.copyWith(status: SpotsBallStatus.registerVerifyOTPLoading));
    try{
      ResponseData responseData = await repository.registerOTPVerify(otp,token);
      emit(state.copyWith(status: SpotsBallStatus.registerVerifyOTPSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: SpotsBallStatus.registerVerifyOTPError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: SpotsBallStatus.registerVerifyOTPError,error: e.toString(),errorData: null));
    }
  }







  Future<void> resendForgotPasswordCall(String emailOrPhone) async {
    emit(state.copyWith(status: SpotsBallStatus.resendForgotPasswordLoading));
    try {
      ResponseData response = await repository.forgotPassword(emailOrPhone);
      emit(state.copyWith(status: SpotsBallStatus.resendForgotPasswordSuccess, responseData: response));
    }
    on ErrorData catch (errorData) {
      emit(state.copyWith(status: SpotsBallStatus.resendForgotPasswordError, errorData: errorData, error: null));
    }
    catch (e) {
      emit(state.copyWith(status: SpotsBallStatus.resendForgotPasswordError, error: e.toString(), errorData: null));
    }
  }

  Future<void> forgotOtpVerifyCall(String otp,String token) async{
    emit(state.copyWith(status: SpotsBallStatus.forgotOtpVerifyLoading));
    try{
      ResponseData responseData = await repository.forgotOtpVerify(otp,token);
      emit(state.copyWith(status: SpotsBallStatus.forgotOtpVerifySuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: SpotsBallStatus.forgotOtpVerifyError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: SpotsBallStatus.forgotOtpVerifyError,error: e.toString(),errorData: null));
    }
  }




  Future<void> getProfileCall() async{
    emit(state.copyWith(status: SpotsBallStatus.getProfileLoading));
    try{
      ResponseData responseData = await repository.getProfile();
      emit(state.copyWith(status: SpotsBallStatus.getProfileSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: SpotsBallStatus.getProfileError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: SpotsBallStatus.getProfileError,error: e.toString(),errorData: null));
    }
  }*/



}
