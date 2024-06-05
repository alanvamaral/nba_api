class Team {
  int id;
  String conference;
  String division;
  String city;
  String name;
  String fullName;
  String abbreviation;

  Team({
    required this.id,
    required this.fullName,
    required this.abbreviation,
    required this.name,
    required this.city,
    required this.division,
    required this.conference,
  });
}
