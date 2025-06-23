$(function (){

    let tableView =  {
        el: "#tableShow",
        url: "/projects/selectLogs/page/all",
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
                 field: "teacherId",
                 title: "教师工号",
                 align: "center",
             },
			{
				field: "teacherName",
				title: "教师姓名",
				align: "center",
			},
			{
				field: "studentName",
				title: "学生姓名",
				align: "center",
			},
            {
                field: "studentId",
                title: "学生学号",
                align: "center",
            }
        ]
    }
    $.table(tableView);

    $(".fater-btn-form-qry").on("click", ()=>{

        tableView.where["teacherName"] = $("[name=para1]").val();
        tableView.where["studentName"] = $("[name=para2]").val();
        tableView.where["gradeId"] = $("[name=para3]").val();
        tableView.where["projectId"] = $("[name=para4]").val();

        $.table(tableView);
    });


});