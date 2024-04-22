class ValidationHelper{

  static bool validateEmail(String? email){
    if(email==null||email.isEmpty){
      return false;
    }else{
      final bool emailValid =
      RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email);
      return emailValid;
    }
  }

  static bool validatePassword(String? password){
    if(password==null||password.isEmpty||password.length<6){
      return false;
    }else{
      return true;
    }
  }

}