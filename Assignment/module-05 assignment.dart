import 'dart:io';

abstract class Role {
  void displayRole();
}

class Person implements Role {
  String name;
  int age;
  String address;

  Person(this.name, this.age, this.address);

  @override
  void displayRole() {
    print("Role: Person");
  }

  void displayInfo() {
    print("Name: $name");
    print("Age: $age");
    print("Address: $address");
  }
}

class Student extends Person {
  String studentID;
  List<int> courseScores;
  String grade = '';

  Student(String name, int age, String address, this.studentID, this.courseScores)
      : super(name, age, address);

  @override
  void displayRole() {
    print("Role: Student");
  }

  double calculateAverageScore() {
    return courseScores.isNotEmpty
        ? courseScores.reduce((a, b) => a + b) / courseScores.length
        : 0.0;
  }

  void calculateGrade() {
    double average = calculateAverageScore();
    if (average >= 90) {
      grade = 'A';
    } else if (average >= 80) {
      grade = 'B';
    } else if (average >= 70) {
      grade = 'C';
    } else if (average >= 60) {
      grade = 'D';
    } else {
      grade = 'F';
    }
  }

  @override
  void displayInfo() {
    super.displayInfo();
    print("Student ID: $studentID");
    print("Average Score: ${calculateAverageScore().toStringAsFixed(1)}");
    calculateGrade();
    print("Grade: $grade");
  }
}

class Teacher extends Person {
  String teacherID;
  List<String> coursesTaught;

  Teacher(String name, int age, String address, this.teacherID, this.coursesTaught)
      : super(name, age, address);

  @override
  void displayRole() {
    print("Role: Teacher");
  }

  @override
  void displayInfo() {
    super.displayInfo();
    print("Teacher ID: $teacherID");
    print("Courses Taught:");
    for (var course in coursesTaught) {
      print("- $course");
    }
  }
}

void main() {
  List<Student> students = [];
  List<Teacher> teachers = [];

  while (true) {
    print("\nMain Menu:");
    print("1. Add Student");
    print("2. Add Teacher");
    print("3. Show All");
    print("4. Exit");
    stdout.write("Choose an option: ");
    String? choice = stdin.readLineSync();

    if (choice == '1') {
      stdout.write("Enter Name: ");
      String name = stdin.readLineSync()!;

      stdout.write("Enter Age: ");
      int age = int.parse(stdin.readLineSync()!);

      stdout.write("Enter Address: ");
      String address = stdin.readLineSync()!;

      stdout.write("Enter Student ID: ");
      String studentID = stdin.readLineSync()!;

      stdout.write("Enter Number of Course Scores: ");
      int scoreCount = int.parse(stdin.readLineSync()!);
      List<int> courseScores = [];

      for (int i = 0; i < scoreCount; i++) {
        stdout.write("Enter Score ${i + 1}: ");
        courseScores.add(int.parse(stdin.readLineSync()!));
      }

      students.add(Student(name, age, address, studentID, courseScores));

    } else if (choice == '2') {
      stdout.write("Enter Name: ");
      String name = stdin.readLineSync()!;

      stdout.write("Enter Age: ");
      int age = int.parse(stdin.readLineSync()!);

      stdout.write("Enter Address: ");
      String address = stdin.readLineSync()!;

      stdout.write("Enter Teacher ID: ");
      String teacherID = stdin.readLineSync()!;

      stdout.write("Enter Number of Courses Taught: ");
      int courseCount = int.parse(stdin.readLineSync()!);
      List<String> coursesTaught = [];

      for (int i = 0; i < courseCount; i++) {
        stdout.write("Enter Course ${i + 1}: ");
        coursesTaught.add(stdin.readLineSync()!);
      }

      teachers.add(Teacher(name, age, address, teacherID, coursesTaught));

    } else if (choice == '3') {
      if (students.isEmpty && teachers.isEmpty) {
        print("No data available.");
      } else {
        if (students.isNotEmpty) {
          print("\n--- Students ---");
          for (var student in students) {
            student.displayRole();
            student.displayInfo();
            print("\n");
          }
        }

        if (teachers.isNotEmpty) {
          print("\n--- Teachers ---");
          for (var teacher in teachers) {
            teacher.displayRole();
            teacher.displayInfo();
            print("\n");
          }
        }
      }

    } else if (choice == '4') {
      print("Exiting... Goodbye!");
      break;
    } else {
      print("Invalid option. Please try again.");
    }
  }
}
