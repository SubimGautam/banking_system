import 'bank_account.dart';
import 'interest_bearing.dart';

class Bank {
  List<BankAccount> _accounts = [];

  void createAccount(BankAccount account) {
    if (findAccount(account.accountNumber) != null) {
      throw Exception('Account with this number already exists');
    }
    _accounts.add(account);
  }

  BankAccount? findAccount(String accNumber) {
    for (var a in _accounts) {
      if (a.accountNumber == accNumber) return a;
    }
    return null;
  }

  void transfer(String fromAcc, String toAcc, double amount) {
    if (amount <= 0) throw ArgumentError('Transfer amount must be positive');
    var from = findAccount(fromAcc);
    var to = findAccount(toAcc);
    if (from == null || to == null) throw Exception('One or both accounts not found');

    try {
      from.withdraw(amount);
      to.deposit(amount);
      from.recordTransaction('Transfer Out', -amount);
      to.recordTransaction('Transfer In', amount);
    } catch (e) {
      throw Exception('Transfer failed: ${e.toString()}');
    }
  }

  void generateReport() {
    print('=== Bank Report ===');
    for (var a in _accounts) {
      a.displayInfo();
    }
  }

  void applyMonthlyInterestAndReset() {
    for (var a in _accounts) {
      if (a is InterestBearing) {
        try {
          (a as InterestBearing).applyInterest();
        } catch (e) {
          print('Failed to apply interest for account ${a.accountNumber}: $e');
        }
      }
      a.resetMonthlyCounters();
    }
  }
}
