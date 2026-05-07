import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharkship/features/kyc/domain/entities/kyc.dart';
import 'package:sharkship/features/kyc/presentation/state/kyc_info_notifier.dart';
import 'package:sharkship/features/kyc/presentation/widgets/profile_card.dart';
import 'package:sharkship/shared/constants/app_colors.dart';
import 'package:sharkship/shared/widgets/loader.dart';

class KycInfo extends ConsumerStatefulWidget {
  const KycInfo({super.key});
  @override
  ConsumerState<KycInfo> createState() => _KycInfoState();
}

class _KycInfoState extends ConsumerState<KycInfo> {
  @override
  void initState() {
    super.initState();
    // Fetch data when page is opened
    Future.microtask(() => ref.read(kycInfo.notifier).refresh());
  }

  @override
  Widget build(BuildContext context) {
    final kycAsync = ref.watch(kycInfo);

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'KYC Info',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.scaffoldBg,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: AppColors.scaffoldBg,
      body: kycAsync.when(
        data: (kyc) => RefreshIndicator(
          onRefresh: () => ref.read(kycInfo.notifier).refresh(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              children: [
                /// Profile Section
                _buildProfileSection(kyc),
                const SizedBox(height: 16),
                if (kyc.pan?.isVerified != null && kyc.pan?.isVerified != false)
                  _buildPanDetails(kyc.pan!),
                const SizedBox(height: 16),

                /// Bank Details Section
                if (kyc.bank?.isVerified != null &&
                    kyc.bank?.isVerified != false)
                  _buildBankDetails(kyc.bank!),
                const SizedBox(height: 16),

                /// GST Details Section
                if (kyc.gst != null && kyc.gst?.isVerified != false)
                  _buildGstDetails(kyc.gst!),
                const SizedBox(height: 16),

                /// Documents Section
                // _buildDocuments(kyc),
                // const SizedBox(height: 50),
              ],
            ),
          ),
        ),
        loading: () => const Center(child: ThreeDotsLoader()),
        error: (error, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Something went wrong'),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => ref.read(kycInfo.notifier).refresh(),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection(Kyc kyc) {
    final name = kyc.user != null
        ? '${kyc.user!.firstName} ${kyc.user!.lastName}'
        : kyc.aadhaar?.aadharName ?? "N/A";

    return ProfileCard(
      name: name,
      imageUrl: kyc.user?.profileImageUrl,
      aadhar: kyc.aadhaar,
      udyam: kyc.udyam,
      dob: kyc.user?.dob,
      email: kyc.user?.email,
      mobile: kyc.user!.phoneNo,
      address: kyc.user?.address,
    );
  }

  Widget _buildPanDetails(PanData pan) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Pan Details',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryBlue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _infoRow('PAN Number:', pan.panNumber),
          _infoRow('PAN Name:', pan.panName ?? ""),
          _infoRow('PAN Type:', pan.panType ?? "N/A"),
        ],
      ),
    );
  }

  Widget _buildBankDetails(BankData bank) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Bank Details',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryBlue,
                ),
              ),
              if (bank.cancelledCheque != null &&
                  bank.cancelledCheque != false) ...[
                Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: AppColors.lightGreen,
                      size: 20,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Cancelled Cheque',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
          const SizedBox(height: 16),
          _infoRow('Account Number:', bank.accountNumber),
          _infoRow('Account Holder:', bank.accountHolderName),
          _infoRow('Account Type:', bank.accountType),
          _infoRow('Bank:', bank.bankName),
          _infoRow('IFSC:', bank.ifscCode),
        ],
      ),
    );
  }

  Widget _buildGstDetails(GstData gst) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'GST Details',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryBlue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _infoRow('GSTIN:', gst.gstNumber),
          _infoRow('Legal Business Name:', gst.gstLegalBusinessName!),
          _infoRow('Trade Name:', gst.gstTradeBusinessName!),
          _infoRow('Constitution:', gst.constitutionOfBusiness!),
          _infoRow(
            'Registration Date:',
            gst.gstRegistrationDate!.toIso8601String(),
          ),
          // _infoRow('Business Address:', gst),
        ],
      ),
    );
  }

  Widget _buildDocuments(Kyc kyc) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Documents',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.primaryBlue,
            ),
          ),
          const SizedBox(height: 16),
          _docRow('Aadhar Front:', 'Aadhar_Front.Doc', kyc.aadhaar != null),
          _docRow('Aadhar Back:', 'Aadhar_Back.Doc', kyc.aadhaar != null),
          _docRow('Pan Card:', 'Pan_Card.Doc', kyc.pan != null),
          _docRow(
            'Cancelled Cheque:',
            'Cancelled_Cheque.Doc',
            (kyc.bank?.cancelledCheque != null &&
                kyc.bank?.cancelledCheque != false),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _docRow(String label, String fileName, bool isUploaded) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$label ',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: fileName,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          if (isUploaded)
            Icon(Icons.check_circle, color: AppColors.lightGreen, size: 20)
          else
            const Icon(Icons.error_outline, color: Colors.red, size: 20),
        ],
      ),
    );
  }
}
