


class Stretch{


  int id;
  String name;
  String image;

  Stretch(int id, String name){
      this.id = id;
      this.name = name;

      image ='assets/stretch-' + (id > 2 ? '0' : id.toString()) + '.jpg';
  }

}
class StretchExercises{


  int id;
  String name;
  List<Stretch> Stretches;

  StretchExercises(int id, String name){
    this.id = id;
    this.name = name;
  }

}

