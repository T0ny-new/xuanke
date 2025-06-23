$(function (){

    let tableView =  {
            el: "#tableShow",
            url: "/projects/selectLogs/student/all",
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
    			{
                    title: "选择课程",
                    template: (d)=>{

                        if(d.isSelected){

                            return `
                                    <button type="button" class="fater-btn fater-btn-disableed fater-btn-sm">
                                        已选
                                    </button>
                                    `;
                        }else{

                            return `
                                    <button type="button" event="select" data="${d.id}" class="fater-btn fater-btn-primary fater-btn-sm">
                                        选择
                                    </button>
                                    `;
                        }

                    }
                }
            ]
        }

    $.table(tableView);

    $("button[event=select]").on("click", (e)=>{

        $.confirm("确认要选择这门课程吗?", () =>{

            $.ajax({
                url: "/projects/selectLogs/add",
                type: "POST",
                async: false,
                data:{
                    planId: $(e.target).attr("data"),
                },
                success: function(res){
                    if(res.code == 0){
                        $.alert(res.msg, () =>{

                            window.location.reload();
                        });
                    }else{
                        $.msg("error", res.msg);
                    }
                }
            });
        });
    });
});