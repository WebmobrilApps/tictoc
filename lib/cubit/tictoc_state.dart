
//part of 'spotsball_cubit.dart';

part of 'tictoc_cubit.dart';

enum TicTocStatus {
  initial,

  signUpLoading,
  signUpSuccess,
  signUpError,

  registerVerifyOTPLoading,
  registerVerifyOTPSuccess,
  registerVerifyOTPError,

  resendVerifyOTPLoading,
  resendVerifyOTPSuccess,
  resendVerifyOTPError,

  signInLoading,
  signInSuccess,
  signInError,

  guestLoginLoading,
  guestLoginSuccess,
  guestLoginError,

  forgotPasswordLoading,
  forgotPasswordSuccess,
  forgotPasswordError,

  forgotOtpVerifyLoading,
  forgotOtpVerifySuccess,
  forgotOtpVerifyError,

  resetPasswordLoading,
  resetPasswordSuccess,
  resetPasswordError,

  userInterestLoading,
  userInterestSuccess,
  userInterestError,

  getProfileLoading,
  getProfileSuccess,
  getProfileError,

  updateProfileLoading,
  updateProfileSuccess,
  updateProfileError,

  changePasswordLoading,
  changePasswordSuccess,
  changePasswordError,

  getAllContestLoading,
  getAllContestSuccess,
  getAllContestError,

  howToPlayLoading,
  howToPlaySuccess,
  howToPlayError,

  pressLoading,
  pressSuccess,
  pressError,

  rulesOfPlayLoading,
  rulesOfPlaySuccess,
  rulesOfPlayError,

  faqLoading,
  faqSuccess,
  faqError,

  deActivateAccountLoading,
  deActivateAccountSuccess,
  deActivateAccountError,

  deleteAccountLoading,
  deleteAccountSuccess,
  deleteAccountError,

  addToCartLoading,
  addToCartSuccess,
  addToCartError,

  getCartLoading,
  getCartSuccess,
  getCartError,

  getCartLoading1,
  getCartSuccess1,
  getCartError1,

  removeCartLoading,
  removeCartSuccess,
  removeCartError,



  getNotificationLoading,
  getNotificationSuccess,
  getNotificationError,

  uidStatusLoading,
  uidStatusSuccess,
  uidStatusError,

  uidStatusLoginLoading,
  uidStatusLoginSuccess,
  uidStatusLoginError,

  socialLoginLoading,
  socialLoginSuccess,
  socialLoginError,

  socialSignUpLoading,
  socialSignUpSuccess,
  socialSignUpError,

  markAsReadAllNotificationLoading,
  markAsReadAllNotificationSuccess,
  markAsReadAllNotificationError,

}


class TicTocState extends Equatable {
  final TicTocStatus status;
  final ResponseData? responseData;
  final ErrorData? errorData;
  final String? error;

  const TicTocState({
    this.status = TicTocStatus.initial,
    this.responseData,
    this.errorData,
    this.error,

  });

  @override
  List<Object?> get props => [
    status,
    responseData,
    errorData,
    error,

  ];

  TicTocState copyWith({
    TicTocStatus? status,
    ResponseData? responseData,
    ErrorData? errorData,
    String? error,
    String? message,
  }) {
    return TicTocState(
      status: status ?? this.status,
      responseData: responseData ?? this.responseData,
      errorData: errorData ?? this.errorData,
      error: error ?? this.error,

    );
  }
}


