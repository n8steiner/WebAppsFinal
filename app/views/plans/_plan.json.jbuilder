json.plan do
    json.id @plan.id
    json.name @plan.name
    json.currYear @plan.current_year
    json.currTerm @plan.current_semester
    json.major @major.name
    json.minor "Bible"
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
json.userPlans do
  @plans.each{
        |plan|
        json.set! plan.id, plan.name
  }
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

json.requirement do
    json.categories do
        @requirement.categories.each {
            |category|
            json.set! category.name do 
                json.courses category.courses do |catCourse|
                    json.course catCourse.identifier
                end
            end
        }
    end
end