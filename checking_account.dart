import 'bank_account.dart';

class CheckingAccount extends BankAccount {
  static const double overdraftFee = 35.0;

  CheckingAccount(String accNum, String holder, [double initial = 0])
      : super(accNum, holder, initial);

  @override
  void deposit(double amount) {
    ensureNonNegative(amount);
    changeBalance(amount);
    recordTransaction('Deposit', amount);
  }

  @override
  void withdraw(double amount) {
    ensureNonNegative(amount);
    changeBalance(-amount);

    if (balance < 0) {
      changeBalance(-overdraftFee);
      recordTransaction('OverdraftFee', -overdraftFee);
    }

    recordTransaction('Withdraw', -amount);
  }
}
