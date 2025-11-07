abstract class BankAccount {
  String _accountNumber;
  String _holderName;
  double _balance = 0.0;
  List<Map<String, dynamic>> transactions = [];

  BankAccount(this._accountNumber, this._holderName, [double initialBalance = 0]) {
    _balance = initialBalance;
  }

  String get accountNumber => _accountNumber;
  String get holderName => _holderName;
  double get balance => _balance;

  set holderName(String name) {
    _holderName = name;
  }

  void recordTransaction(String type, double amount) {
    transactions.add({
      'date': DateTime.now(),
      'type': type,
      'amount': amount,
      'balance': _balance
    });
  }

  void displayInfo() {
    print('Account Number: $_accountNumber');
    print('Holder: $_holderName');
    print('Balance: \$${_balance.toStringAsFixed(2)}');
    print('Transactions:');
    for (var t in transactions) {
      print('${t['date']}: ${t['type']} \$${t['amount']} => Balance: \$${t['balance']}');
    }
    print('-----------------------------');
  }

  void resetMonthlyCounters() {}

  void changeBalance(double amount) {
    _balance += amount;
  }

  void ensureNonNegative(double value) {
    if (value < 0) {
      throw ArgumentError('Amount must be non-negative');
    }
  }

  void deposit(double amount);
  void withdraw(double amount);
}
