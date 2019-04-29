json.plan do
    json.id @plan.id
    json.courses @plan.plan_courses do |planCourse|
        json.identifier planCourse.course.identifier
       json.year planCourse.year
      json.term planCourse.term
  end
  json.year @plan.year
end
