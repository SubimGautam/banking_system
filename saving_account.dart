import 'bank_account.dart';
import 'interest_bearing.dart';

class SavingsAccount extends BankAccount implements InterestBearing {
  static const double minBalance = 500;
  static const double interestRate = 0.02;
  static const int maxWithdrawalsPerMonth = 3;

  int _withdrawals = 0;

  SavingsAccount(String accNum, String holder, [double initial = 0])
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
    if (_withdrawals >= maxWithdrawalsPerMonth) {
      throw Exception('Withdrawal limit reached for this month');
    }
    if (balance - amount < minBalance) {
      throw Exception('Cannot go below minimum balance of $minBalance');
    }

    changeBalance(-amount);
    _withdrawals++;
    recordTransaction('Withdraw', -amount);
  }

  @override
  void applyInterest() {
    double interest = balance * interestRate;
    changeBalance(interest);
    recordTransaction('Interest', interest);
  }

  @override
  void resetMonthlyCounters() {
    _withdrawals = 0;
  }
}
