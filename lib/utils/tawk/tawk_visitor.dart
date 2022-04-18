/// Use [TawkVisitor] to set the visitor name and email.
class TawkVisitor {
  /// Visitor's name.
  final String name;

  /// Visitor's email.
  final String email;

  /// [Secure mode](https://developer.tawk.to/jsapi/#SecureMode).
  final String? hash;

  TawkVisitor({
    required this.name,
    required this.email,
    this.hash,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['name'] = name;

    data['email'] = email;

    if (hash != null) {
      data['hash'] = hash;
    }

    return data;
  }
}
