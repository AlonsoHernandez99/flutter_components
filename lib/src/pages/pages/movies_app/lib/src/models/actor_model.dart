class Cast {
  List<Actor> actors = [];

  Cast.fromJsonList(List<dynamic> response) {
    if (response == null) return;
    response.forEach((element) => actors.add(Actor.fromJsonMap(element)));
  }
}

class Actor {
  bool adult;
  int gender;
  int id;
  String name;
  String originalName;
  double popularity;
  String profilePath;
  int castId;
  String character;
  String creditId;
  int order;
  String job;

  Actor({
    this.adult,
    this.gender,
    this.id,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    this.creditId,
    this.order,
    this.job,
  });

  Actor.fromJsonMap(Map<String, dynamic> json) {
    adult = json["adult"];
    gender = json["gender"];
    id = json["id"];
    name = json["name"];
    originalName = json["original_name"];
    popularity = json["popularity"];
    profilePath = json["profile_path"];
    castId = json["castId"];
    character = json["character"];
    creditId = json["creditId"];
    order = json["order"];
    job = json["job"];
  }

  getPhoto() {
    return profilePath != null
        ? "https://image.tmdb.org/t/p/w500/$profilePath"
        : "https://img.freepik.com/vector-gratis/perfil-avatar-hombre-icono-redondo_24640-14044.jpg?size=338&ext=jpg";
  }
}
