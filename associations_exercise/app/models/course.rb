# == Schema Information
#
# Table name: courses
#
#  id            :bigint(8)        not null, primary key
#  name          :string
#  prereq_id     :integer
#  instructor_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Course < ApplicationRecord
    has_many(:enrollments, 
        {class_name: 'Enrollment',
        foreign_key: :course_id,
        primary_key: :id})

    has_one(:prerequisite_1,
    {class_name: 'Course',
    foreign_key: :id,
    primary_key: :prereq_id})

    belongs_to(:prerequisite_2,
    {class_name: 'Course',
    foreign_key: :prereq_id,
    primary_key: :id})

    has_one(:instructor,
    class_name: 'User',
    primary_key: :instructor_id,
    foreign_key: :id)

    has_many(:students, through: :enrollments, source: :student)    

end
