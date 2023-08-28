public class FutureMixedDMLClass {
  public static void mixedDMLMethod() {
    // No-Setup DML operation
    Account a = new Account(Name = 'Acme');
    insert a;

    // Setup DML operation (user role change)
    FutureClass.insertUserWithRole(
      'username22@test.com',
      'Yingjia',
      'email@test.com',
      'Zhang'
    );
  }
}
