import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/features/kyc/domain/entities/kyc.dart';
import 'package:sharkship/features/kyc/domain/usecases/get_kyc_details_usecase.dart';
import 'package:sharkship/features/user/presentation/state/user_providers.dart';
import 'kyc_provider.dart';

part 'kyc_info_notifier.g.dart';

@Riverpod(keepAlive: false, name: 'kycInfo')
class KycInfoNotifier extends _$KycInfoNotifier {
  @override
  FutureOr<Kyc> build() async {
    return _fetch();
  }

  Future<Kyc> _fetch() async {
    final details = await ref.read(getKycDetailsUseCaseProvider).call();

    // Map KycResponseModel to Kyc Entity
    return Kyc(
      aadhaar: details.isAadhaarComplete
          ? AadhaarData(
              frontImage: details.aadharFrontUrl,
              backImage: details.aadharBackUrl,
              aadharName: details.aadharName,
              aadharNumber: details.aadharNumber,
              aadharProfileImage: details.aadharProfileImage,
              isVerified: (details.aadharVerified ?? false),
              dob: details.dob,
              address: details.address,
            )
          : null,
      pan: details.isPanComplete
          ? PanData(
              panNumber: details.pan ?? "",
              isVerified: details.panVerified ?? false,
              panName: details.panName,
              panIncorporationDate: details.panIncorporationDate,
              panType: details.panType,
            )
          : null,
      bank: details.isBankComplete
          ? BankData(
              accountHolderName: details.accountHolderName ?? "",
              accountNumber: details.accountNumber ?? "",
              ifscCode: details.ifsc ?? "",
              accountType: details.accountType ?? "",
              bankName: details.bankName ?? "",
              cancelledCheque: details.cancelledCheque,
              isVerified: details.accountHolderName != null,
            )
          : null,
      gst: details.isGstComplete
          ? GstData(
              gstNumber: details.gstin ?? "",
              isVerified: details.gstVerificationStatus ?? false,
              gstAnnexureUrl: details.gstAnnexureUrl,
              gstLegalBusinessName: details.gstLegalBusinessName,
              gstTradeBusinessName: details.gstTradeBusinessName,
              gstRegistrationDate: details.gstRegistrationDate,
              constitutionOfBusiness: details.constitutionOfBusiness,
            )
          : null,
      udyam: details.udyamNumber != null
          ? UdyamData(
              udyamNumber: details.udyamNumber,
              enterpriseName: details.enterpriseName,
              organizationType: details.organizationType,
              majorActivity: details.majorActivity,
              dateOfIncorporation: details.dateOfIncorporation,
              dateOfCommencement: details.dateOfCommencement,
              dateOfUdyamRegistration: details.dateOfUdyamRegistration,
              enterpriseType: details.enterpriseType,
              udyamCertificateUrl: details.udyamCertificateUrl,
              udyamAddress: details.udyamAddress,
            )
          : null,
      cin: details.cinDetails != null
          ? CinData(
              cin: details.cinDetails?.cin,
              companyName: details.cinDetails?.companyName,
              registrationNumber: details.cinDetails?.registrationNumber,
              cinEmail: details.cinDetails?.cinEmail,
              incorporationDate: details.cinDetails?.incorporationDate,
              directors: details.cinDetails?.directors
                  ?.map((d) => DirectorData(
                        name: d.name,
                        din: d.din,
                        designation: d.designation,
                        dob: d.dob,
                      ))
                  .toList(),
            )
          : null,
      status: details.status ?? "INITIATED",
      isSubmitted: details.kycTicketStatus == "PENDING" ||
          details.kycTicketStatus == "RESOLVED",
      agreementAccepted: details.agreementAccepted ?? false,
      entityType: details.entityType ?? "SOLE_PROPRIETORSHIP",
      user: details.userData,
    );
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetch());
  }
}
