import 'bank_account.dart';
import 'interest_bearing.dart';

class PremiumAccount extends BankAccount implements InterestBearing {
  static const double minBalance = 10000.0;
  static const double interestRate = 0.05;

  PremiumAccount(String accNum, String holder, [double initial = 0])
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
    if (balance - amount < minBalance) {
      throw Exception(
          'Cannot withdraw. Minimum balance of \$${minBalance.toStringAsFixed(2)} required.');
    }
    changeBalance(-amount);
    recordTransaction('Withdraw', -amount);
  }

  @override
  void applyInterest() {
    double interest = balance * interestRate;
    changeBalance(interest);
    recordTransaction('Interest', interest);
  }
}
