class UserGlobal {
  String? uid;
  String? email;
  String? token;
  String? name;
  String? code;
  DateTime? createdAt;
  DateTime? lastSeen;
  int? recomendedMovies;
  int? recomendedSongs;
  int? recomendedActivities;
  String? partnerCode;
  String? partnerName;

  UserGlobal({
    this.uid,
    this.email,
    this.token,
    this.name,
    this.code,
    this.createdAt,
    this.lastSeen,
    this.recomendedMovies,
    this.recomendedSongs,
    this.recomendedActivities,
    this.partnerCode,
    this.partnerName,
  });

  factory UserGlobal.fromFirestore(Map<String, dynamic> data) {
    return UserGlobal(
      uid: data['uid'] ?? '',
      email: data['email'] ?? '',
      token: data['token'] ?? '',
      name: data['name'] ?? '',
      code: data['code'] ?? '',
      createdAt: data['createdAt'].toDate(),
      lastSeen: data['lastSeen'].toDate(),
      recomendedMovies: data['recomendedMovies'],
      recomendedSongs: data['recomendedSongs'],
      recomendedActivities: data['recomendedActivities'],
      partnerCode: data['partnerCode'],
      partnerName: data['partnerName'],
    );
  }

  factory UserGlobal.fromMap(Map<String, dynamic> data) {
    return UserGlobal(
      uid: data['uid'],
      email: data['email'],
      token: data['token'],
      name: data['name'],
      code: data['code'],
      createdAt: data['createdAt'].toDate(),
      lastSeen: data['lastSeen'].toDate(),
      recomendedMovies: data['recomendedMovies'],
      recomendedSongs: data['recomendedSongs'],
      recomendedActivities: data['recomendedActivities'],
      partnerCode: data['partnerCode'],
      partnerName: data['partnerName'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'token': token,
      'name': name,
      'code': code,
      'createdAt': createdAt,
      'lastSeen': lastSeen,
      'recomendedMovies': recomendedMovies,
      'recomendedSongs': recomendedSongs,
      'recomendedActivities': recomendedActivities,
      'partnerCode': partnerCode,
      'partnerName': partnerName,
    };
  }
}
