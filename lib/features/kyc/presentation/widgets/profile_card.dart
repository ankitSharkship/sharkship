import 'package:flutter/material.dart';
import 'package:sharkship/features/kyc/domain/entities/kyc.dart';
import 'package:sharkship/shared/constants/app_colors.dart';

class ProfileCard extends StatelessWidget {
  final String? name;
  final String? imageUrl;
  final AadhaarData? aadhar;
  final UdyamData? udyam;
  final String? dob;
  final String? email;
  final String mobile;
  final String? address;

  const ProfileCard({
    super.key,
    this.name,
    this.imageUrl,
    this.aadhar,
    this.udyam,
    this.dob,
    this.email,
    required this.mobile,
    this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Profile Image
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primaryBlue.withOpacity(0.2),
                    width: 4,
                  ),
                ),
                child: imageUrl != null && imageUrl != ""
                    ? CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 36,
                        backgroundImage: NetworkImage(imageUrl!),
                      )
                    : CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 36,
                        child: Icon(
                          Icons.person,
                          size: 40,
                          color: AppColors.primaryBlue,
                        ),
                      ),
              ),

              const SizedBox(width: 16),

              /// Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Name
                    Text(
                      name ?? "User",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryBlue,
                          ),
                    ),

                    const SizedBox(height: 6),
                    _row(context, "Mobile Number:", mobile),
                    if (email != null && email != "")
                      _row(context, "Email:", email!),
                    if (dob != null && dob != "") _row(context, "D.O.B:", dob!),

                    if (aadhar?.aadharNumber != null &&
                        aadhar?.aadharNumber != "")
                      _row(context, "Aadhar:", aadhar!.aadharNumber!),

                    if (udyam?.udyamNumber != null && udyam?.udyamNumber != "")
                      _row(context, "Udyam:", udyam!.udyamNumber!),
                  ],
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 6),

              /// Priority Address display: Aadhaar -> Udyam -> User Address
              if (aadhar?.address != null && aadhar?.address != "")
                _addressDisplay(context, aadhar!.address!)
              else if (udyam?.udyamAddress != null && udyam?.udyamAddress != "")
                _addressDisplay(context, udyam!.udyamAddress!)
              else if (address != null && address != "")
                _addressDisplay(context, address!),
            ],
          ),
        ],
      ),
    );
  }

  Widget _addressDisplay(BuildContext context, String addressValue) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "Address: ",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
          ),
          TextSpan(
            text: addressValue,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.black87,
                ),
          ),
        ],
      ),
    );
  }

  Widget _row(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "$label ",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
            ),
            TextSpan(
              text: value,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.black87,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
