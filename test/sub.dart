
final Expando<Person> ep = Expando<Person>();


void main(){
  Person person = Person('toly');
  person.join("合肥市第 10 中学");
  Student s = ep[person] as Student;
  print("${s.name}:${s.school}");
}

class Student extends Person{
  final String school;
  Student(this.school,super.name);

}

class Person{
  final String name;

  Person(this.name);

  void join(String school){
    ep[this] = Student(school, name);
  }
}