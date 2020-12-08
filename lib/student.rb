class Student

  attr_reader :name, :grade, :id

  @@all = []

    def initialize(name, grade, id = nil)
      @name = name
      @grade = grade
      @@all << self
    end

    def self.create_table
      sql = "
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY, 
        name TEXT, 
        grade TEXT)"
      DB[:conn].execute(sql) 
    end

    def self.drop_table
      sql = "DROP TABLE students"
      DB[:conn].execute(sql) 
    end

    def save
        sql = "INSERT INTO students (name, grade) VALUES (?, ?)"
      DB[:conn].execute(sql, self.name, self.grade)
      @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
    end

    def self.create(hash)
      @student = Student.new(hash[:name], hash[:grade])
      @student.save
      @student
    end
end
