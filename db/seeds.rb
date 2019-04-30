# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user1 = User.new
user1.login = "joe"
user1.email = "joe@cedarville.edu"
user1.password = "password"
user1.password_confirmation = "password"
user1.save!

user2 = User.new
user2.login = "pete"
user2.email = "pete@cedarville.edu"
user2.password = "password"
user2.password_confirmation = "password"
user2.save!

major = Major.create(name: "Computer Science")

#give joe a couple of plans
plan1 = Plan.new
plan1.user_id = user1.id
plan1.name = "Plan1"
plan1.year = "2016"
plan1.current_semester = "Fall"
plan1.current_year = "2017"
plan1.major_id = major.id
plan1.save!

plan2 = Plan.new
plan2.user_id = user1.id
plan2.name = "Plan2"
plan2.year = "2016"
plan2.current_semester = "Fall"
plan2.current_year = "2016"
plan2.major_id = major.id
plan2.save!

catalog = Catalog.create(year: "2016")
requirement = Requirement.create(catalog_id: catalog.id, major_id: major.id)

coreCat = Category.create(name: "Computer Science Core", requirement_id:  requirement.id)
reqCat = Category.create(name: "Required Cognates", requirement_id:  requirement.id)
genEdCat = Category.create(name: "Gen-Ed", requirement_id:  requirement.id)
bibleCat = Category.create(name: "Bible Minor", requirement_id:  requirement.id)

course1 = Course.create(identifier: "BTGE-1720", name: "Spifo", description: "Weening from spiritual milk", credit_hours: 3)
course2 = Course.create(identifier: "MATH-1710", name: "Calculus I", description: "Weed out the weak", credit_hours: 5)
course3 = Course.create(identifier: "PEF-1990", name: "PACAL", description: "Nap time!", credit_hours: 2)
course4 = Course.create(identifier: "COM-1100", name: "Fundamentals of Speach", description: "Learn how to speak. Course will introduce students to words such as \"useless\" and \"eye contact\"", credit_hours: 3)
course5 = Course.create(identifier: "CS-1210", name: "C++ Programming", description: "Segmentation fault (core dumped)", credit_hours: 2)
course6 = Course.create(identifier: "EGCP-1010", name: "Digital Logic Design", description: "There is a way that appears to be right, but in the end it leads to death (Prov. 14:12)", credit_hours: 4)
course7 = Course.create(identifier: "HUM-1400", name: "Intro to Humanities", description: "I laughed, I cried, it moved me", credit_hours: 3)
course8 = Course.create(identifier: "MATH-1720", name: "Calculus II", description: "lim(gpa -> 0) job(gpa) = 0", credit_hours: 5)
course9 = Course.create(identifier: "PHYS-2110", name: "General Physics I", description: "Dishonest scales are an abomination to the LORD", credit_hours: 4)
course10 = Course.create(identifier: "CS-1220", name: "Object Oriented C++", description: "Cars are MotorVehicles are Vehicles are Objects", credit_hours: 3)
course11 = Course.create(identifier: "BTGE-2730", name: "OT Lit", description: "Miller Time", credit_hours: 3)
course12 = Course.create(identifier: "CS-2210", name: "Data Structures", description: "AKA Intro to Gallagher", credit_hours: 3)
course13 = Course.create(identifier: "CS-3320", name: "Operating Systems", description: "Ostrich Algorithm", credit_hours: 3)
course14 = Course.create(identifier: "GSS-1100", name: "PAC", description: "Learn how your government works", credit_hours: 3)
course15 = Course.create(identifier: "PHYS-2120", name: "Physics II", description: "It's electric!", credit_hours: 4)
course16 = Course.create(identifier: "BTGE-2740", name: "NT Lit", description: "Matthew, Mark, Luke, and John, Acts, Romans...", credit_hours: 3)
course17 = Course.create(identifier: "CS-3210", name: "Foundations of Computer Security", description: "Learn how to be a script kiddie", credit_hours: 3)
course18 = Course.create(identifier: "HIST-1120", name: "US History II", description: "The Gilded Age with Dr. Mach", credit_hours: 3)
course19 = Course.create(identifier: "MATH-2520", name: "Discrete Math/Prob", description: "Learn how to play poker", credit_hours: 3)
course20 = Course.create(identifier: "BTGE-3755", name: "Theology I", description: "God, sin, and man, what's not to love?", credit_hours: 3)
course21 = Course.create(identifier: "CS-3320", name: "Linux Systems Programming", description: "Don't bollocks it up", credit_hours: 3)
course22 = Course.create(identifier: "CS-3620", name: "Algorithms", description: "Gallagoritms or Shomperitms? That is the question.", credit_hours: 3)
course23 = Course.create(identifier: "EGCP-4310", name: "Computer Networks", description: "Learn how to use TCP over optical telegraph", credit_hours: 3)
course24 = Course.create(identifier: "BTPA-2200", name: "Intro to Philosophy", description: "You don't have hands, free will, or a soul", credit_hours: 3)
course25 = Course.create(identifier: "CS-3220", name: "Web Applications", description: "Get ready for the hardest tests of your life", credit_hours: 3)
course26 = Course.create(identifier: "CS-4310", name: "Cyber Operations", description: "There are two final exams", credit_hours: 3)
course27 = Course.create(identifier: "CS-3610", name: "Database Org & Design", description: "Run your own university", credit_hours: 3)
course28 = Course.create(identifier: "CS-4810", name: "Software Engineering I", description: "You're almost there", credit_hours: 3)
course29 = Course.create(identifier: "CS-4330", name: "Software Security", description: "Reverse engineer all the things", credit_hours: 3)
course30 = Course.create(identifier: "EGGN-4010", name: "Senior Seminar", description: "This is how to act like you know what you're doing", credit_hours: 3)


PlanCourse.create(plan_id: plan1.id, course_id: course1.id, term: "Fall", year: "2016")
PlanCourse.create(plan_id: plan1.id, course_id: course2.id, term: "Fall", year: "2016")
PlanCourse.create(plan_id: plan1.id, course_id: course3.id, term: "Fall", year: "2016")
PlanCourse.create(plan_id: plan1.id, course_id: course4.id, term: "Fall", year: "2016")
PlanCourse.create(plan_id: plan1.id, course_id: course5.id, term: "Fall", year: "2016")
PlanCourse.create(plan_id: plan1.id, course_id: course6.id, term: "Spring", year: "2017")
PlanCourse.create(plan_id: plan1.id, course_id: course7.id, term: "Spring", year: "2017")
PlanCourse.create(plan_id: plan1.id, course_id: course8.id, term: "Spring", year: "2017")
PlanCourse.create(plan_id: plan1.id, course_id: course9.id, term: "Spring", year: "2017")
PlanCourse.create(plan_id: plan1.id, course_id: course10.id, term: "Fall", year: "2017")
PlanCourse.create(plan_id: plan1.id, course_id: course11.id, term: "Fall", year: "2017")
PlanCourse.create(plan_id: plan1.id, course_id: course13.id, term: "Fall", year: "2017")
PlanCourse.create(plan_id: plan1.id, course_id: course14.id, term: "Spring", year: "2018")
PlanCourse.create(plan_id: plan1.id, course_id: course15.id, term: "Spring", year: "2018")
PlanCourse.create(plan_id: plan1.id, course_id: course16.id, term: "Fall", year: "2018")
PlanCourse.create(plan_id: plan1.id, course_id: course17.id, term: "Fall", year: "2018")
PlanCourse.create(plan_id: plan1.id, course_id: course18.id, term: "Fall", year: "2018")
PlanCourse.create(plan_id: plan1.id, course_id: course19.id, term: "Spring", year: "2019")
PlanCourse.create(plan_id: plan1.id, course_id: course20.id, term: "Spring", year: "2019")
PlanCourse.create(plan_id: plan1.id, course_id: course21.id, term: "Fall", year: "2019")
PlanCourse.create(plan_id: plan1.id, course_id: course22.id, term: "Fall", year: "2019")
PlanCourse.create(plan_id: plan1.id, course_id: course23.id, term: "Spring", year: "2020")
PlanCourse.create(plan_id: plan1.id, course_id: course24.id, term: "Spring", year: "2020")
PlanCourse.create(plan_id: plan1.id, course_id: course25.id, term: "Spring", year: "2020")
PlanCourse.create(plan_id: plan1.id, course_id: course30.id, term: "Spring", year: "2020")

CategoryCourse.create(course_id: course1.id, category_id: bibleCat.id)
CategoryCourse.create(course_id: course2.id, category_id: reqCat.id)
CategoryCourse.create(course_id: course3.id, category_id: genEdCat.id)
CategoryCourse.create(course_id: course4.id, category_id: genEdCat.id)
CategoryCourse.create(course_id: course5.id, category_id: coreCat.id)
CategoryCourse.create(course_id: course6.id, category_id: coreCat.id)
CategoryCourse.create(course_id: course7.id, category_id: genEdCat.id)
CategoryCourse.create(course_id: course8.id, category_id: reqCat.id)
CategoryCourse.create(course_id: course9.id, category_id: reqCat.id)
CategoryCourse.create(course_id: course10.id, category_id: coreCat.id)
CategoryCourse.create(course_id: course11.id, category_id: bibleCat.id)
CategoryCourse.create(course_id: course12.id, category_id: coreCat.id)
CategoryCourse.create(course_id: course13.id, category_id: coreCat.id)
CategoryCourse.create(course_id: course14.id, category_id: genEdCat.id)
CategoryCourse.create(course_id: course15.id, category_id: reqCat.id)
CategoryCourse.create(course_id: course16.id, category_id: bibleCat.id)
CategoryCourse.create(course_id: course17.id, category_id: coreCat.id)
CategoryCourse.create(course_id: course18.id, category_id: genEdCat.id)
CategoryCourse.create(course_id: course19.id, category_id: reqCat.id)
CategoryCourse.create(course_id: course20.id, category_id: bibleCat.id)
CategoryCourse.create(course_id: course21.id, category_id: coreCat.id)
CategoryCourse.create(course_id: course22.id, category_id: coreCat.id)
CategoryCourse.create(course_id: course23.id, category_id: coreCat.id)
CategoryCourse.create(course_id: course24.id, category_id: genEdCat.id)
CategoryCourse.create(course_id: course25.id, category_id: coreCat.id)
CategoryCourse.create(course_id: course26.id, category_id: coreCat.id)
CategoryCourse.create(course_id: course27.id, category_id: coreCat.id)
CategoryCourse.create(course_id: course28.id, category_id: coreCat.id)
CategoryCourse.create(course_id: course29.id, category_id: coreCat.id)
CategoryCourse.create(course_id: course30.id, category_id: coreCat.id)

CatalogCourse.create(catalog_id: catalog.id, course_id: course1.id)
CatalogCourse.create(catalog_id: catalog.id, course_id: course2.id)
CatalogCourse.create(catalog_id: catalog.id, course_id: course3.id)
CatalogCourse.create(catalog_id: catalog.id, course_id: course4.id)
CatalogCourse.create(catalog_id: catalog.id, course_id: course5.id)
CatalogCourse.create(catalog_id: catalog.id, course_id: course6.id)
CatalogCourse.create(catalog_id: catalog.id, course_id: course7.id)
CatalogCourse.create(catalog_id: catalog.id, course_id: course8.id)
CatalogCourse.create(catalog_id: catalog.id, course_id: course9.id)
CatalogCourse.create(catalog_id: catalog.id, course_id: course10.id)
CatalogCourse.create(catalog_id: catalog.id, course_id: course11.id)
CatalogCourse.create(catalog_id: catalog.id, course_id: course12.id)
CatalogCourse.create(catalog_id: catalog.id, course_id: course13.id)
CatalogCourse.create(catalog_id: catalog.id, course_id: course14.id)
CatalogCourse.create(catalog_id: catalog.id, course_id: course15.id)
CatalogCourse.create(catalog_id: catalog.id, course_id: course16.id)
CatalogCourse.create(catalog_id: catalog.id, course_id: course17.id)
CatalogCourse.create(catalog_id: catalog.id, course_id: course18.id)
CatalogCourse.create(catalog_id: catalog.id, course_id: course19.id)
CatalogCourse.create(catalog_id: catalog.id, course_id: course20.id)
CatalogCourse.create(catalog_id: catalog.id, course_id: course21.id)
CatalogCourse.create(catalog_id: catalog.id, course_id: course22.id)
CatalogCourse.create(catalog_id: catalog.id, course_id: course23.id)
CatalogCourse.create(catalog_id: catalog.id, course_id: course24.id)
CatalogCourse.create(catalog_id: catalog.id, course_id: course25.id)
CatalogCourse.create(catalog_id: catalog.id, course_id: course26.id)
CatalogCourse.create(catalog_id: catalog.id, course_id: course27.id)
CatalogCourse.create(catalog_id: catalog.id, course_id: course28.id)
CatalogCourse.create(catalog_id: catalog.id, course_id: course29.id)
CatalogCourse.create(catalog_id: catalog.id, course_id: course30.id)