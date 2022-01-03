import 'package:flutter_test/flutter_test.dart';
import './test_function.dart';

main() {
  // test("Test Name", () {
  //   String name = TestingFUnction.testString('Denuke');
  //
  //   expect(name, 'Denuke');
  // });

  group('Validate email', (){
    test('Valid email', (){
      bool emailValidation = TestUserEmail.testEmail('ddnadhananja@gmail.com');
      expect(emailValidation, true);
    });

    test('Invalid email - without @', (){
      bool emailValidation = TestUserEmail.testEmail('ddnadhananjagmail.com');
      expect(emailValidation, false);
    });

    test('Invalid email - without .com', (){
      bool emailValidation = TestUserEmail.testEmail('ddnadhananja@gmail');
      expect(emailValidation, false);
    });

    test('Invalid email - without .', (){
      bool emailValidation = TestUserEmail.testEmail('ddnadhananja@gmailcom');
      expect(emailValidation, false);
    });

    test('Invalid email - capital letters', (){
      bool emailValidation = TestUserEmail.testEmail('ddnadHananja@gmail.com');
      expect(emailValidation, false);
    });

  });

  group('Validate Passweord', () {
    test('Valid Password', (){
      bool isValied = TestUserPassword.testPassword('validPassword');
      expect(isValied , true);
    });

    test('Invalid Password - length is 2', (){
      bool isValied = TestUserPassword.testPassword('va');
      expect(isValied , false);
    });

    test('Invalid Password - empty', (){
      bool isValied = TestUserPassword.testPassword('');
      expect(isValied , false);
    });

  });
}
