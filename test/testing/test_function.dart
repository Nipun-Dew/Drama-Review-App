class TestingFUnction {
  static String testString(String name) {
    if (name == 'Denuke') return 'Denuke';
    return 'Not Denuke';
  }
}


class TestUserEmail{
  static bool testEmail(String email){
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
    return emailValid;
  }
}

class TestUserPassword{
  static bool testPassword(String password){
    return password.length > 4 ? true : false;
  }
}