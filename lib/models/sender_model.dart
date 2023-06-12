class Sender {
  final String? fullName;
  final String? email;
  final String? phoneNumber;
  final String? nationalIdNumber;
  final String? address;

  Sender({
    this.fullName,
    this.email,
    this.phoneNumber,
    this.nationalIdNumber,
    this.address,
  });

  Sender.fromJson(Map<String, dynamic> json)
      : fullName = json['fullName'] as String?,
        email = json['email'] as String?,
        phoneNumber = json['phoneNumber'] as String?,
        nationalIdNumber = json['nationalIdNumber'] as String?,
        address = json['address'] as String?;

  Map<String, dynamic> toJson() => {
        'fullName': fullName,
        'email': email,
        'phoneNumber': phoneNumber,
        'nationalIdNumber': nationalIdNumber,
        'address': address
      };
}
