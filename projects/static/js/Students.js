function handle(){

	$("button[event=upd]").on("click", (e)=>{

        $.ajax({
            url: "/projects/students/info",
            type: "GET",
            async: false,
            data:{
                id: $(e.target).attr("data"),
            },
            success: function(res){
                if(res.code == 0){

                    $.initForm("updForm", res.data);
                    $.model(".updWin");
                }else{
                    $.msg("error", res.msg);
                }
            }
        });
    });

    $("button[event=del]").on("click", (e)=>{

        $.confirm("确认要删除吗", () =>{

            $.ajax({
                url: "/projects/students/del",
                type: "POST",
                async: false,
                data:{
                    id: $(e.target).attr("data"),
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
}

$(function (){

    let tableView =  {
        el: "#tableShow",
        url: "/projects/students/page",
        method: "GET",
        where: {
            pageIndex: 1,
            pageSize: 10
        },
        page: true,
        cols: [
            {
                field: "id",
                title: "学生学号",
                align: "center",
            },
            {
                field: "name",
                title: "学生姓名",
                align: "center",
            },
            {
                field: "age",
                title: "学生年龄",
                align: "center",
            },
            {
                field: "gender",
                title: "学生性别",
                align: "center",
            },
            {
				field: "majorName",
				title: "所学专业",
				align: "center",
			},
			{
				field: "collegeName",
				title: "所在学院",
				align: "center",
			},
			{
				field: "gradeName",
				title: "所在年级",
				align: "center",
			},
			{
                title: "操作",
                template: (d)=>{

                    return `
                            <button type="button" event="upd" data="${d.id}" class="fater-btn fater-btn-primary fater-btn-sm">
                                <span data="${d.id}" class="fa fa-edit"></span>
                            </button>
                            <button type="button" event="del" data="${d.id}" class="fater-btn fater-btn-danger fater-btn-sm">
                                <span data="${d.id}" class="fa fa-trash"></span>
                            </button>
                            `;
                }
            }
        ]
    }
    $.table(tableView);

    $(".fater-btn-form-qry").on("click", ()=>{

        tableView.where["studentName"] = $("[name=para1]").val();
        tableView.where["collegeId"] = $("[name=para2]").val();
        tableView.where["majorId"] = $("[name=para3]").val();
        tableView.where["gradeId"] = $("[name=para4]").val();

        $.table(tableView);
        
        handle();
    });

    $("button[event=add]").on("click", ()=>{

        $.model(".addWin");
    });

	handle();

    $("#addFormBtn").on("click", ()=>{

        let formVal = $.getFrom("addForm");

        $.ajax({
            url: "/projects/students/add",
            type: "POST",
            data: formVal,
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

    $("#updFormBtn").on("click", ()=>{

        let formVal = $.getFrom("updForm");

        $.ajax({
            url: "/projects/students/upd",
            type: "POST",
            data: formVal,
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