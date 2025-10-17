class FakeAuthService {
  // This simulates a successful login.
  // It returns true immediately.
  Future<bool> fakeSignIn() async {
    print('--- FAKE LOGIN SUCCESSFUL ---');
    // Simulate a small delay, like a real network call.
    await Future.delayed(const Duration(milliseconds: 500));
    return true;
  }

  // This simulates logging out.
  Future<void> signOut() async {
    print('--- FAKE LOGOUT ---');
  }
}