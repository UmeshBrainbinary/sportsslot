import 'package:sportsslot/presentation/help_screen/models/help_item_modal.dart';

/// This class defines the variables used in the [help_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class HelpModel {
  static List<HelpItemModal> getHelpItem () {
    return [
      HelpItemModal(
        question: "How do I search for stadiums or grounds in my area?",
        answer: "You can easily search for stadiums or grounds by using the search bar on the app's homepage. Simply type in your location or desired venue, and relevant options will be displayed.",
      ),

      HelpItemModal(
        question: "Can I filter search results based on specific criteria, such as capacity or amenities?",
        answer: "You can easily search for stadiums or grounds by using the search bar on the app's homepage. Simply type in your location or desired venue, and relevant options will be displayed.",
      ),

      HelpItemModal(
        question: "How do I make a booking for a stadium or ground?",
        answer: "To make a booking, select the desired stadium or ground from the search results, choose the date and time for your booking, and proceed to the booking confirmation page. Follow the prompts to complete the booking process and make payment if required.",
      ),

      HelpItemModal(
        question: "Is it possible to view detailed information about a stadium or ground before making a booking?",
        answer: "Yes, you can view detailed information about each stadium or ground listed on the app, including photos, description, amenities, availability, and pricing. This information will help you make an informed decision before booking.",
      ),

      HelpItemModal(
        question: "Can I cancel or modify my booking after it has been confirmed?",
        answer: "The cancellation and modification policies may vary depending on the stadium or ground you have booked. You can review the specific policies on the",
      ),

    ];
  }
}