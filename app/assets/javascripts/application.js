// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery-ui
//= require dataTables/jquery.dataTables
//= require rails-ujs
//= require turbolinks
//= require_tree .


function logout() {
    $.ajax({
        type: "DELETE",
        url: "/users/sign_out",
        success: function(msg){
            location.reload();
        }
    });
}

let courses = [];

let catalogTable = null;

let plan = {
    planName: "",
    catalogYear: 2010,
    major: "Comp. Sci.",
    studentName: "First Last",
    currentSemester: 20100,
    currentSemesterId: "Spring2010",
    courses: [],
    years: []
};

function Course(term, year, courseID, courseName, creditHours, isPlanned) {
    this.term = term;
    this.year = year;
    this.courseID = courseID;
    this.courseName = courseName;
    this.creditHours = creditHours;
    this.isPlanned = isPlanned;

    this.html = function (hasTaken) {
        let drag = "draggable='true' ondragstart='drag(event)'";

        if (hasTaken === 2) {
            drag = "";
        }

        return "<span class='course' id='p" + this.courseID + "' " + drag + ">" + this.courseID + " " + this.courseName + "</span>";
    };
}

function Semester(term, year, hasTaken) {
    this.term = term;
    this.year = year;
    this.hasTaken = hasTaken;
    this.courses = [];

    this.html = function () {
        let complete = "";
        let id = this.term + "V" + this.year;
        let drag = "ondrop='drop(event)' ondragover='allowDrop(event)'";
        if (this.hasTaken > 1) {
            complete = " complete";
            drag = "";
        } else if (this.hasTaken === 1) {
            complete = " inProgress";
            plan.currentSemesterId = id;
        }

        let courseList = "";

        let creditHours = 0;

        for (let key in this.courses) {
            creditHours += this.courses[key].creditHours;
            courseList += this.courses[key].html(this.hasTaken)
        }

        return "<div class='semester" + complete + "' id='" + id + "' " + drag + ">" +
            "<div class='semesterName'>" + this.term + " " + this.year + "</div> " +
            "<div class='semesterHours'>Hours: " + creditHours + "</div> " +
            "<div class='courseList'><span class='course' style='border:none'></span>" + courseList + "</div>" +
            "</div>"

    };

    this.hours = function () {
        let creditHours = 0;
        for (let key in this.courses) {
            creditHours += this.courses[key].creditHours;
        }

        return creditHours;
    }

}

function Year(year) {
    this.year = year;
    this.semester = [];

    this.html = function () {
        let semesterList = "";

        semesterList += this.semester['Fall'].html();
        semesterList += this.semester['Spring'].html();
        semesterList += this.semester['Summer'].html();

        return "<div class='year' id='year" + this.year + "'>" + semesterList + "</div>"
    }
	
	this.hours = function () {
		let numHours = 0;
		for (let key in this.semester) {
			numHours += this.semester[key].hours();
		}
		
		return numHours;
	}
}

$(document).ready(function() {
    $.ajax({
        url: "plans.json",
        type: 'GET',
        success: function (res) {
            let data = res;
            getPageInfo(data.userPlans[0].id);
        }
    });
});

function populatePlansDropdown(data){
    let result = "<option selected hidden disabled>Plan: "+ data.plan.name +"</option>";
    for(let key in data.userPlans){
        result += "<option value=" + key + ">"+ data.userPlans[key] +"</option>";
    }

    result += "<option value='new'> + New Plan</option>";
    $("#plans").html(result);
}

function getPageInfo(planId){
    if (planId === "new") {
        window.location.replace("plans/new")
        return;
    }

    $.ajax({
        url: "plans/" + planId + ".json",
        type: 'GET',
        success: function (res) {
            let data = res;

            clearPage();
            setUpCatalog(data);
            setUpPlan(data);
            setUpAccordion(data);
            
            populatePlansDropdown(data);
        }
    });
}

function clearPage(){
    courses = [];
    plan.courses = [];
    plan.years = [];
    if($("#accordion").data("ui-accordion")){
        $("#accordion").accordion('destroy');
    }    
    if(catalogTable != null){
        catalogTable.clear();
    }
}

function setUpCatalog(data) {
    catalogTable = $('#catalog').DataTable({
        destroy: true,
        "paging": false,        
        scrollY: '100%',
        language: {
            search: "_INPUT_",
            searchPlaceholder: "Search"
        },

        fixedHeader: {
            header: true,
            footer: true
        }
    });

    // add rows
    for (let key in data.catalog.courses) {
        let course = data.catalog.courses[key];
        courses[key] = new Course("none", 0, course.id, course.name, course.credits);
        catalogTable.row.add([
            course.id,
            course.name,
            course.description,
            course.credits
        ]).draw(true);
    }

    // add drag/drop to rows
    let rows = $.merge($("#catalog .even"), $("#catalog .odd"));
    for (let row in rows) {
        if (row < rows.length)
            $(rows[row]).attr({
                draggable: 'true',
                ondragstart: 'drag(event)',
                id: "r" + catalogTable.row(rows[row]).data()[0]
            });
    }

    //set up auto complete
    jQuery('<div/>', {
        id: 'textSuggest',
        class: 'textSuggest',
        title: ''
    }).appendTo('#catalog_filter');
    let curAutoComplete = "";
    $('input[type="search"]').keydown(function (e) {
        var keyCode = e.keyCode || e.which;

        if (keyCode == 9 && $('.textSuggest').html().trim()) {
            e.preventDefault();
            $('input[type="search"]').val(curAutoComplete);
        }
    });
    $('input[type="search"]').keyup(function () {
        if (!$('input[type="search"]').val().trim()) {
            $(".textSuggest").css({display: "none"});
        } else {
            let searchInput = $('input[type="search"]').val().toUpperCase();
            let searchPosition = $('input[type="search"]').position();
            $("#hiddenWidth").html(searchInput);
            $('input[type="search"]').val(searchInput);
            $(".textSuggest").css({
                display: "block",
                top: searchPosition.top + 4,
                left: searchPosition.left + $("#hiddenWidth").width() + 12
            });
            $(".textSuggest").html("");
            for (let course in courses) {
                if (course.toUpperCase().startsWith(searchInput) && course !== searchInput) {
                    curAutoComplete = course;
                    $(".textSuggest").html(course.toUpperCase().substr(searchInput.length) + " (tab to complete)");
                    break;
                } else if (courses[course].courseName.toUpperCase().startsWith(searchInput) && courses[course].courseName.toUpperCase() != searchInput) {
                    curAutoComplete = courses[course].courseName.toUpperCase();
                    $(".textSuggest").html(courses[course].courseName.toUpperCase().substr(searchInput.length) + " (tab to complete)");
                }
            }
        }
    });
}

function setUpPlan(data) {
    // set up plan
    plan.currentSemester = (data.plan.currYear * 10) + (data.plan.currTerm == "Spring" ? 0 : data.plan.currTerm == "Summer" ? 1 : 2);

    for (let key in data.plan.courses) {
        let course = data.plan.courses[key];
        courses[key].isPlanned = true;
        courses[key].year = course.year;
        courses[key].term = course.term;
        plan.courses[key] = courses[key];
    }

    for (let key in plan.courses) {
        let courseYear = plan.courses[key].year;
        let fallCourseYear = courseYear;
        if (plan.courses[i = key].term === "Fall") {
            courseYear = courseYear + 1;
        }
        if (plan.years[courseYear.toString()] == null) {

            plan.years[courseYear.toString()] = new Year(fallCourseYear + "-" + courseYear);
            plan.years[courseYear.toString()].semester['Fall'] = new Semester('Fall', fallCourseYear, ((fallCourseYear * 10 + 2) < plan.currentSemester) ? 2 : ((fallCourseYear * 10 + 2) === plan.currentSemester) ? 1 : 0);
            plan.years[courseYear.toString()].semester['Spring'] = new Semester('Spring', courseYear, ((courseYear * 10) < plan.currentSemester) ? 2 : ((courseYear * 10) === plan.currentSemester) ? 1 : 0);
            plan.years[courseYear.toString()].semester['Summer'] = new Semester('Summer', courseYear, ((courseYear * 10 + 1) < plan.currentSemester) ? 2 : ((courseYear * 10 + 1) === plan.currentSemester) ? 1 : 0);
        }
        plan.years[courseYear].semester[plan.courses[key].term].courses[key] = plan.courses[key];
    }

    let html = "";
	let programHours = 0;
    for (let key in plan.years) {
		programHours += plan.years[key].hours();
        html += plan.years[key].html();
    }

    document.getElementById("studentName").innerHTML = data.plan.student.replace(/\b\w/g, l => l.toUpperCase());
    document.getElementById("major").innerHTML = "Major: " + data.plan.major;
	document.getElementById("minor").innerHTML = "Minor: " + data.plan.minor;
	document.getElementById("hours").innerHTML = "Total Hours: " + programHours;
    document.getElementById("catalogYear").innerHTML = "Catalog: " + data.plan.catYear;
    document.getElementById("ur").innerHTML = html;
    document.getElementById(plan.currentSemesterId).scrollIntoView({behavior: 'smooth', block: 'center'});
}


function setUpAccordion(data) {
    let accordion = $("#accordion")[0];
    accordion.innerHTML = "<h3 id=\"reqTitle\" class=\"ui-state-disabled\">Requirements</h3><div></div>";

    for (let category in data.requirement.categories) {
        let newHtml = ""
        newHtml += "<h3 class='reqSubHeader'>" + category + "</h3><div><ul>";
        let courseArr = data.requirement.categories[category].courses;
        for (let c in courseArr) {
            let course = courseArr[c];
            let courseClass = "";
            if (courses[course.course].isPlanned) {
                courseClass = " class='planned'"
            }
            newHtml += "<li id='" + course + "' " + courseClass + "' draggable='true' ondragstart='drag(event)'>" + courses[course.course].courseID + " " + courses[course.course].courseName + "</li>";
        }

        accordion.innerHTML += newHtml + "</ul></div>";
    }


    $("#accordion").accordion({
        heightStyle: "fill"
    });
    $("#accordion .reqSubHeader:eq(0)").trigger('click');
}

function allowDrop(ev) {
    ev.preventDefault();
}

function drag(ev) {
    ev.dataTransfer.setData("text", ev.target.localName + "," + ev.target.id);
    let data = ev.target.id;

    if (ev.target.localName == "span") {
        let semester = $(ev.target);
        if (!semester.attr('class').includes("semester")) {
            semester = semester.closest(".semester");
        }

        data = data.substr(1);
        let course = courses[data];
        let year = semester[0].id.split("V")[1];
        course.term = semester[0].id.split("V")[0];
        course.year = year;
        if (course.term === "Fall") {
            year = parseInt(year) + 1;
        }
        delete plan.years[year].semester[course.term].courses[course.courseID];
        $("#" + semester[0].id + " .semesterHours").html("Hours: " + plan.years[year].semester[course.term].hours());
    }
}

function drop(ev) {
    ev.preventDefault();
    let data = ev.dataTransfer.getData("text").split(",");
    let semester = $(ev.target);
    if (!semester.attr('class').includes("semester")) {
        semester = semester.closest(".semester");
    }

    if (data[0] !== "li") {
        data[1] = data[1].substr(1);
    }

    if (data[0] !== "span" && plan.courses[data[1]]) {
        //from https://www.polonel.com/snackbar/
        Snackbar.show({
            text: 'Course already added to plan.',
            showAction: false,
            pos: 'bottom-left',
            showAction: true,
            actionText: 'Dismiss',
            backgroundColor: "#00395C",
            textColor: "#EFEFEF",
            actionTextColor: "#FC7C00",
            fontWeight: "bold"
        });
        return;
    }

    let course = courses[data[1]];
    course.isPlanned = true;
    let year = semester[0].id.split("V")[1];
    course.term = semester[0].id.split("V")[0];
    course.year = year;

    if (course.term === "Fall") {
        year = parseInt(year) + 1;
    }

    plan.years[year].semester[course.term].courses[course.courseID] = course;
    $("#" + semester[0].id + " .semesterHours").html("Hours: " + plan.years[year].semester[course.term].hours());
    plan.courses[course.courseID] = course;

    if (data[0] !== "span") {
        $($(semester).find(".courseList")[0])[0].innerHTML += course.html();
        $(document).find("#" + data[1]).addClass("planned");
    } else {
        $($(semester).find(".courseList")[0]).append(document.getElementById("p" + data[1]));
    }
	
	updateHours();
}

function bodyDrop(ev) {
    ev.preventDefault();
    let data = ev.dataTransfer.getData("text").split(",");
    let target = $(ev.target);
    if (ev.target.className.includes("semester")) {
        return
    }
    if (!target.parents().is(".semester")) {
        let data = ev.dataTransfer.getData("text").split(",");

        if (data[0] === "span") {
            let course = courses[data[1].substr(1)];
            course.isPlanned = false;
            course.year = 0;
            course.term = "none";
            $(document.getElementById(data[1].substr(1))).removeClass("planned");
            $((document.getElementById(data[1])).remove());
            delete plan.courses[data[1].substr(1)];

            for (let key in plan.courses) {
                console.log(key)
            }
        }
    }
	
	updateHours();
}

function updateHours() {
	let programHours = 0;
	for (let key in plan.years) {
		programHours += plan.years[key].hours();
    }
	
	document.getElementById("hours").innerHTML = "Total Hours: " + programHours;
}