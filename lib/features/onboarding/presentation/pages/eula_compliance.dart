import 'package:audition/features/onboarding/presentation/widget/style/text_style/text_style.dart';
import 'package:audition/resources/app_constants/app_string.dart';
import 'package:audition/resources/helpers/extensions.dart';
import 'package:audition/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class EulaComplianceScreen extends StatelessWidget {
  const EulaComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalAppBar(
        paddingOptional: true,
        title: AppString.eulaCompliance,
        child: ListView(
          children: [
            title("1. Acceptance of Terms"),
            5.verticalSpace,
            subTitle(
                "By accessing, downloading, installing, or using this application (Software), you acknowledge that you have read, understood, and agreed to be bound by this End User License Agreement (Agreement). If you do not agree to these terms, you must not use the Software."),
            5.verticalSpace,
            title("2. License Grant"),
            5.verticalSpace,
            subTitle(
                "Subject to your compliance with this Agreement, Bigee grants you a limited, non-exclusive, non-transferable, revocable license to use the Software solely for personal, non-commercial purposes."),
            5.verticalSpace,
            title("3. Prohibited Conduct"),
            5.verticalSpace,
            subTitle("You agree not to use the Software to:"),
            subTitle(
                "Post, upload, share, or distribute any content that is illegal, defamatory, harassing, abusive, fraudulent, obscene, hateful, or otherwise objectionable."),
            subTitle(
                "Engage in any activity that threatens, harasses, degrades, or intimidates any individual or group based on religion, gender, sexual orientation, race, ethnicity, age, or disability."),
            subTitle(
                "Violate any applicable laws, regulations, or third-party rights."),
            subTitle("Transmit malware, viruses, or any other harmful code."),
            subTitle(
                "Circumvent, disable, or interfere with security-related features of the Software."),
            5.verticalSpace,
            title("4. No Tolerance for Objectionable Content"),
            5.verticalSpace,
            subTitle(
                "Bigee enforces a strict zero-tolerance policy for objectionable content. Any violation of this policy may result in the immediate suspension or termination of your access to the Software, with or without notice. We reserve the right to remove any content that we determine to be in violation of this Agreement."),
            5.verticalSpace,
            title("5. Content Monitoring and Enforcement"),
            5.verticalSpace,
            subTitle(
                "Bigee reserves the right, but is not obligated, to monitor user activity and content to ensure compliance with this Agreement. If any violations are found, we may take appropriate action, including but not limited to:"),
            subTitle("Issuing warnings"),
            subTitle("Removing content"),
            subTitle("Suspending or terminating user accounts"),
            subTitle("Reporting violations to legal authorities"),
            5.verticalSpace,
            title("6. Termination"),
            5.verticalSpace,
            subTitle(
                "This Agreement remains in effect until terminated by you or Bigee. You may terminate this Agreement by discontinuing use of the Software and uninstalling it. Bigee may terminate your access at any time if you violate any provision of this Agreement."),
            5.verticalSpace,
            title("7. Disclaimer of Warranties"),
            5.verticalSpace,
            subTitle(
                "The Software is provided as is and as available without warranties of any kind, whether express or implied. Bigee does not warrant that the Software will be uninterrupted or error-free."),
            5.verticalSpace,
            title("8. Limitation of Liability"),
            5.verticalSpace,
            subTitle(
                "To the fullest extent permitted by law, Bigee shall not be liable for any damages arising from your use or inability to use the Software."),
            5.verticalSpace,
            title("9. Changes to this Agreement"),
            5.verticalSpace,
            subTitle(
                "Bigee reserves the right to modify this Agreement at any time. Continued use of the Software after changes are posted constitutes acceptance of the updated terms."),
            5.verticalSpace,
            title("10. Contact Information"),
            5.verticalSpace,
            subTitle(
                "If you have any questions about this Agreement, please contact us at [Company Contact Information]."),
            5.verticalSpace,
            subTitle(
                "By using the Software, you acknowledge that you have read, understood, and agree to this End User License Agreement.")
          ],
        ));
  }

  Widget title(String title) {
    return Text(title, style: CustomTextStyle.headerTextStyle());
  }

  Widget subTitle(String title) {
    return Text(title, style: CustomTextStyle.appButtonTextStyle());
  }
}
