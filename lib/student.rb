class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]

  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade,id=nil)
    self.name = name
    self.grade = grade

  end

  def self.create_table
    sql = "CREATE TABLE IF NOT EXISTS students (id INTEGER PRIMARY KEY, name TEXT, grade TEXT);"
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE students;"
    DB[:conn].execute(sql)
  end

  def save
    sql = "INSERT INTO students (name, grade) VALUES ('#{self.name}', '#{self.grade}');"
    DB[:conn].execute(sql)

    sql = "SELECT MAX(id) FROM students;"
    @id = DB[:conn].execute(sql).flatten[0]
  end

  def self.create(attributes)
    new_student = Student.new(attributes[:name], attributes[:grade])
    new_student.save
    new_student

  end


end # of Student class
