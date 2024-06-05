import 'package:sportsslot/presentation/privacy_policy_screen/models/privacy_policy_item_modal.dart';

/// This class defines the variables used in the [privacy_policy_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class PrivacyPolicyModel {
  static List<PrivacyPolicyItemModal> getPolicyData () {
    return [
      PrivacyPolicyItemModal(
          title: "Information Collection",
          data: [
            "We may collect personal information such as your name, email address, phone number, and payment details when you register an account or make a booking through our app.",
            "We also gather non-personal information such as device information, usage statistics, and analytics data to improve our services and enhance your experience.",
          ],
      ),

      PrivacyPolicyItemModal(
        title: "Use of Information",
        data: [
          "Your personal information is utilized to process bookings, facilitate communication, and provide customer support.",
          "We may use non-personal information for analytics, marketing, and improving our app's functionality.",
        ],
      ),

      PrivacyPolicyItemModal(
        title: "Data Security",
        data: [
          "We employ industry-standard security measures to protect your personal information from unauthorized access, disclosure, alteration, or destruction.",
          "Your payment information is encrypted and securely transmitted using SSL (Secure Socket Layer) technology.",
        ],
      ),

      PrivacyPolicyItemModal(
        title: "Sharing of Information",
        data: [
          "We do not sell, trade, or rent your personal information to third parties without your consent.",
          "We may share your information with trusted service providers who assist us in operating our app, conducting business, or servicing you, as long as they agree to keep your information confidential.",
        ],
      ),

      PrivacyPolicyItemModal(
        title: "Cookies and Tracking",
        data: [
          "We may use cookies and similar tracking technologies to enhance your browsing experience and collect information about how you use our app. You can adjust your device settings to refuse cookies, although this may affect some functionalities of the app.",
        ],
      ),

      PrivacyPolicyItemModal(
        title: "Third-Party Links",
        data: [
          "Our app may contain links to third-party websites or services. We are not responsible for the privacy practices or content of these third parties. We encourage you to review their privacy policies before providing any personal information.",
        ],
      ),

      PrivacyPolicyItemModal(
        title: "Changes to Privacy Policy",
        data: [
          "We reserve the right to update or modify this Privacy Policy at any time. Any changes will be effective immediately upon posting the updated Privacy Policy on our app. We encourage you to review this Privacy Policy periodically for any updates.",
        ],
      ),
    ];
  }
}
