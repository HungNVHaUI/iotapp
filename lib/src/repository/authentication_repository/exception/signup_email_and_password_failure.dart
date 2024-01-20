


class SignupEmailAndPasswordFailure {
  final String message;

  const SignupEmailAndPasswordFailure([this.message = "An know error occurred"]);

  factory SignupEmailAndPasswordFailure.code(String code) {
    switch(code){
      case 'weak-password' : return const SignupEmailAndPasswordFailure('Please enter a stronger password');
      case 'invalid-password' : return const SignupEmailAndPasswordFailure('Email is not valid or badly formatted');
      case 'email-already-in-user' : return const SignupEmailAndPasswordFailure('An account already exists for that email');
      case 'operation-not-allowed' : return const SignupEmailAndPasswordFailure('Operation is not allowed. Please contact support');
      case 'user-disable' : return const SignupEmailAndPasswordFailure('This user has been disable. Please contact support');


      default: return const SignupEmailAndPasswordFailure();
    }
  }

}