abstract class IForgotPasswordDatasource {
  Future<bool> sendMailForgotPassword(String email);
}

class ForgotPasswordDatasourceImpl implements IForgotPasswordDatasource {
  @override
  Future<bool> sendMailForgotPassword(String email) async {
    return true;
  }
}
