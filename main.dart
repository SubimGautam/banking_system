import 'dart:io';
import 'bank.dart';
import 'bank_account.dart';
import 'saving_account.dart';
import 'checking_account.dart';
import 'premium_account.dart';
import 'student_account.dart';

void main() {
  var bank = Bank();

  while (true) {
    print('=== BANK MENU ===');
    print('1. Create Account');
    print('2. Deposit');
    print('3. Withdraw');
    print('4. Transfer');
    print('5. Show All Accounts');
    print('6. Apply Monthly Interest & Reset');
    print('0. Exit');
    stdout.write('Choose option: ');
    var choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        stdout.write('Enter account type (savings/checking/premium/student): ');
        var type = stdin.readLineSync();
        stdout.write('Enter account number: ');
        var accNum = stdin.readLineSync()!;
        stdout.write('Enter holder name: ');
        var holder = stdin.readLineSync()!;
        stdout.write('Enter initial balance: ');
        var balance = double.tryParse(stdin.readLineSync()!) ?? 0;

        try {
          BankAccount account;
          if (type == 'savings') {
            account = SavingsAccount(accNum, holder, balance);
          } else if (type == 'checking') {
            account = CheckingAccount(accNum, holder, balance);
          } else if (type == 'premium') {
            account = PremiumAccount(accNum, holder, balance);
          } else if (type == 'student') {
            account = StudentAccount(accNum, holder, balance);
          } else {
            print('Invalid account type');
            break;
          }
          bank.createAccount(account);
          print('Account created successfully!');
        } catch (e) {
          print('Error: $e');
        }
        break;

      case '2':
        stdout.write('Enter account number: ');
        var accNum = stdin.readLineSync()!;
        var account = bank.findAccount(accNum);
        if (account == null) {
          print('Account not found');
          break;
        }
        stdout.write('Enter deposit amount: ');
        var amount = double.tryParse(stdin.readLineSync()!) ?? 0;
        try {
          account.deposit(amount);
          print('Deposit successful!');
        } catch (e) {
          print('Error: $e');
        }
        break;

      case '3':
        stdout.write('Enter account number: ');
        var accNum = stdin.readLineSync()!;
        var account = bank.findAccount(accNum);
        if (account == null) {
          print('Account not found');
          break;
        }
        stdout.write('Enter withdrawal amount: ');
        var amount = double.tryParse(stdin.readLineSync()!) ?? 0;
        try {
          account.withdraw(amount);
          print('Withdrawal successful!');
        } catch (e) {
          print('Error: $e');
        }
        break;

      case '4':
        stdout.write('Enter FROM account number: ');
        var fromAcc = stdin.readLineSync()!;
        stdout.write('Enter TO account number: ');
        var toAcc = stdin.readLineSync()!;
        stdout.write('Enter transfer amount: ');
        var amount = double.tryParse(stdin.readLineSync()!) ?? 0;
        try {
          bank.transfer(fromAcc, toAcc, amount);
          print('Transfer successful!');
        } catch (e) {
          print('Transfer error: $e');
        }
        break;

      case '5':
        bank.generateReport();
        break;

      case '6':
        bank.applyMonthlyInterestAndReset();
        print('Monthly interest applied and counters reset!');
        break;

      case '0':
        print('Exiting...');
        return;

      default:
        print('Invalid option');
    }

    print('\n'); // blank line for readability
  }
}
