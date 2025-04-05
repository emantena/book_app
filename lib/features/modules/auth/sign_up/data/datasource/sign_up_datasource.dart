abstract class SignUpDatasource {
  Future<bool> signUp(
      String email, String password, String name, DateTime dateOfBirth);
}

class SignUpDatasourceImpl implements SignUpDatasource {
  @override
  Future<bool> signUp(
      String email, String password, String name, DateTime dateOfBirth) async {
    return true;
  }
}
