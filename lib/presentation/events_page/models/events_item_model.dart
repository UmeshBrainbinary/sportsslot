/// This class is used in the [events_item_widget] screen.

class EventsItemModel {
  List? image;
  String? tournamentName;
  String? location;
  String? description;
  String? lastDayOfRegistration;
  String? entryFee;
  String? matchDate;
  String? tournamentTime;
  String? ticketPrice;
  String? date;
  List previousImage;
  String? url;

  EventsItemModel(
      this.image, this.tournamentName,this.location,
      this.description,
      this.lastDayOfRegistration, this.entryFee, this.matchDate, this.tournamentTime, this.ticketPrice ,this.date, this.previousImage, this.url);
}
