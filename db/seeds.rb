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

#give joe a couple of plans
plan1 = Plan.new
plan1.user_id = user1.id
plan1.name = "Plan1"
plan1.year = "1984"
plan1.save!

plan2 = Plan.new
plan2.user_id = user1.id
plan2.name = "Plan2"
plan2.year = "2012"
plan2.save!

course1 = Course.new
course1.identifier = "BTGE-1720"
course1.name = "Spifo"
course1.description = "Weening from spiritual milk."
course1.credit_hours = 3
course1.save!

plancourse1 = PlanCourse.new
plancourse1.plan_id = plan1.id
plancourse1.course_id = course1.id
plancourse1.term = "Fall"
plancourse1.year = "2019"
plancourse1.save!

catalog = Catalog.new
catalog.year = "1984"
catalog.save!

catalogCourse = CatalogCourse.new
catalogCourse.catalog_id = catalog.id
catalogCourse.course_id = course1.id
catalogCourse.save!