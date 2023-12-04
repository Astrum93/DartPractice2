abstract interface class Pokemon<T extends Type> {
  T createPokemon();
}

class FirePokemon extends Pokemon {
  @override
  Type createPokemon() {
    return Fire();
  }
}

class ElectricPokemon extends Pokemon {
  @override
  Type createPokemon() {
    return Electric();
  }
}

class WaterPokemon extends Pokemon {
  @override
  Type createPokemon() {
    return Water();
  }
}

abstract interface class Type {
  String get type;
}

class Electric extends Type {
  @override
  String get type => "electric";
}

class Fire extends Type {
  @override
  String get type => "fire";
}

class Water extends Type {
  @override
  String get type => "water";
}

abstract interface class PokemonFactory<T extends Pokemon> {
  T createPokemon();
}

class FirePokemonFactory implements PokemonFactory<FirePokemon> {
  @override
  FirePokemon createPokemon() {
    return FirePokemon();
  }
}


PokemonFactory getFactory() => FirePokemonFactory();
