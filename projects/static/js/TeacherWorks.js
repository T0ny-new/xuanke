$(function (){

    let tableView =  {
            el: "#tableShow",
            url: "/projects/workPalns/list",
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
    				field: "gradeName",
    				title: "班级名称",
    				align: "center",
    			}
            ]
        }

    $.table(tableView);
});