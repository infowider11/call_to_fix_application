enum AdminApprovalStatus{
  accepted, rejected, pending
}

class UserModal {
  String id;
  String fullName;
  String userName;
  String email;
  String city;
  String phoneCode;
  String phoneNumber;
  String password;
  String userType;
  String idProofImage;
  String drivingLicenseImage;
  String professionalCertificate;
  bool isEmailVerified;
  String profilePicture;
  bool isActive;
  AdminApprovalStatus isApprovedByAdmin;
  String country;
  String serviceFee;
  String workingHours;
  String videoConsultFee;
  Map sourceOfIncome;
  List<Map> servicesOffered;



  UserModal(
      {required this.id,
      required this.fullName,
      required this.userName,
      required this.email,
      required this.city,
      required this.phoneCode,
      required this.phoneNumber,
      required this.password,
      required this.userType,
      required this.sourceOfIncome,
      required this.idProofImage,
      required this.drivingLicenseImage,
      required this.professionalCertificate,
        required this.profilePicture,
        required this.country,
        required this.isActive,
        required this.isApprovedByAdmin,
        required this.isEmailVerified,
        required this.serviceFee,
        required this.servicesOffered,
        required this.videoConsultFee,
        required this.workingHours
      });

  factory UserModal.fromJson(Map json) {
    return UserModal(
      id: json['id'],
      fullName: json['full_name'],
      userName: json['user_name'],
      email: json['email'],
      city: json['city'],
      phoneCode: json['phone_code'],
      phoneNumber: json['phone_number'],
      password: json['password'],
      userType: json['user_type'],
      sourceOfIncome: json['source_of_income'],
      idProofImage: json['id_proof'],
      drivingLicenseImage: json['driving_license'],
      professionalCertificate: json['profession_certificate'],
      country: json['country'],
      isActive: json['status']=='1'?true:false,
      isApprovedByAdmin: json['approved_by_admin']=='1'?AdminApprovalStatus.accepted:json['approved_by_admin']=='0'?AdminApprovalStatus.pending:AdminApprovalStatus.rejected,
      profilePicture: json['image'],
      isEmailVerified: json['email_verified']=='1'?true:false,
      serviceFee: json['service_fee'],
      servicesOffered: json['work_category'],
      videoConsultFee: json['video_consult_fee'],
      workingHours: json['working_hours'],
    );
  }
}
