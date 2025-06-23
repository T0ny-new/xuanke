$(function (){

    let tableView =  {
            el: "#tableShow",
            url: "/projects/selectLogs/student/selected",
            method: "GET",
            page: false,
            cols: [
                {
                    type: "number",
                    title: "序号",
                },
                {
    				field: "projectName",
    				title: "课程名称",
    				align: "center",
    			},
                {
    				field: "teacherName",
    				title: "授课教师",
    				align: "center",
    			},
                {
    				field: "teacherGender",
    				title: "教师性别",
    				align: "center",
    			},
                {
    				field: "teacherRecord",
    				title: "教师学历",
    				align: "center",
    			},
            ]
        }

    $.table(tableView);

});