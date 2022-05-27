class People {
  // people list

  final String profile, name, tickle;
  final List<String> tags;

  People(
      {required this.profile,
      required this.name,
      required this.tickle,
      required this.tags});
}

// stranger list
List<People> strangers = [
  People(
      profile: "assets/images/smith.jpg",
      name: "Will Smith",
      tickle: "Black Lives Matter!",
      tags: ["Actor", "Husband", "Oscar", "Black People", "Movies"]),
];

// friend list
List<People> friends = [
  People(
      profile: "assets/images/friend.jpg",
      name: "Eileen",
      tickle: "Thank u all for the love!",
      tags: ["Ski", "China", "Stanford", "Model", "Olympic"]),
];
