json.plan do
    json.id @plan.id
    json.student current_user.login

    json.catYear @plan.year
    json.courses do
        @plan.plan_courses.each {
            |planCourse|
            json.set! planCourse.course.identifier do
                json.id planCourse.course.identifier
                json.year planCourse.year
                json.term planCourse.term
            end
        }
    end
end
json.userPlans @plans do |plan|
    json.id plan.id
    json.name plan.name
end
json.catalog do
    json.year @catalog.year

    json.courses do 
        @catalog.catalog_courses.each{
            |catCourse|
            json.set! catCourse.course.identifier do 
                json.id catCourse.course.identifier
                json.name catCourse.course.name
                json.description catCourse.course.description
                json.credits catCourse.course.credit_hours
            end
        }        
    end
end