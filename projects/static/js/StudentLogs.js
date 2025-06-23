$(function (){

    let tableView =  {
        el: "#tableShow",
        url: "/projects/selectLogs/page/teacher",
        method: "GET",
        where: {
            pageIndex: 1,
            pageSize: 10
        },
        page: true,
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
                field: "gradeName",
                title: "班级名称",
                align: "center",
            },
             {
                field: "studentName",
                title: "学生姓名",
                align: "center",
            },
            {
                field: "studenGender",
                title: "学生性别",
                align: "center",
            },
            {
                field: "studenColleges",
                title: "所在学院",
                align: "center",
            },
            {
                field: "studenMajors",
                title: "所学专业",
                align: "center",
            },
        ]
    }

    $.table(tableView);

    $(".fater-btn-form-qry").on("click", ()=>{

        tableView.where["gradeId"] = $("[name=para1]").val();
        tableView.where["studentName"] = $("[name=para2]").val();

        $.table(tableView);
    });

});