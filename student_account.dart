import 'bank_account.dart';

class StudentAccount extends BankAccount {
  static const double maxBalance = 5000.0;

  StudentAccount(String accNum, String holder, [double initial = 0])
      : super(accNum, holder, initial) {
    if (initial > maxBalance) {
      throw Exception('Initial balance exceeds maximum allowed for StudentAccount.');
    }
  }

  @override
  void deposit(double amount) {
    ensureNonNegative(amount);
    if (balance + amount > maxBalance) {
      throw Exception(
          'Deposit would exceed StudentAccount maximum balance of \$${maxBalance.toStringAsFixed(2)}.');
    }
    changeBalance(amount);
    recordTransaction('Deposit', amount);
  }

  @override
  void withdraw(double amount) {
    ensureNonNegative(amount);
    if (amount > balance) {
      throw Exception('Insufficient funds');
    }
    changeBalance(-amount);
    recordTransaction('Withdraw', -amount);
  }
}
