import 'package:test/expect.dart';

abstract class Digimon {}

class Agumon extends Digimon {
  Agumon(this.worldName);

  final String worldName;

  factory Agumon.creator(String companyName) => Agumon(companyName);
}

class Patamon extends Digimon {
  Patamon();

  factory Patamon.creator(String companyName) => Patamon();
}

enum DigimonType {
  AgumonType(Agumon.creator),
  PatamonType(Patamon.creator);

  const DigimonType(this.digimonCreator);

  final Digimon Function(String companyName) digimonCreator;
}

