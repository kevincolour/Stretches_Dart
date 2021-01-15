


class Stretch{

  String id;
  String name;
  String image;
  String description;
  int duration;

  Stretch(String id, String name, int duration, String description){
      this.id = id;
      this.name = name;
      this.duration = duration;
      this.description = description;

      image ='assets/' + name + '.png';
  }

}
class StretchExercises{


  int id;
  String name;
  int duration;
  int exercisesCount;
  List<Stretch> Stretches;

  StretchExercises(int id, String name, int duration, int exercisesCount){
    this.id = id;
    this.name = name;
    this.duration = duration;
    this.exercisesCount = exercisesCount;
    Stretches = [];
  }

}

