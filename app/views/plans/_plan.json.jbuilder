json.plan do
    json.id @plan.id
    json.courses @plan.plan_courses do |planCourse|
        json.number planCourse.course.number
       json.year planCourse.year
      json.term planCourse.term
  end
end
